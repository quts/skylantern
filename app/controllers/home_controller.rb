# app/controller/home.rb
class HomeController < ApplicationController
  include RestGraph::RailsUtil
  before_filter :login_facebook, :only => [:login]
  before_filter :load_facebook, :except => [:login]

  #get '/'
  def index
    @access_token = rest_graph.access_token

    if @access_token
      @user = rest_graph.get('/me')
      @user_friend = rest_graph.get('/me/friends')

      #generate friend list
      @friends = Array.new
      @user_friend['data'].each do|friend|
        friend_in = User.find_by_user_id(friend['id'])
        if(friend_in.nil?) #friend does not in sky lantern
          @friends.push(:id => friend['id'], :name => friend['name'], :in => false)
        else #friend in sky lantern
          @friends.push(:id => friend['id'], :name => friend['name'], :in => true)  
        end      
      end

      #check user in db
      current_user = User.find_by_user_id(@user['id'])
      if(current_user.nil?)
          new_user = User.new(:user_id =>@user['id'] , :friend_id => @friends )
          new_user.save
      else
          current_user.update_attribute( :friend_id, @friends )
      end

      #generate msg_feed
      @msg_feed = Msg.order("start_time DESC").all

    else
      render 'out'
    end
  end

  #get '/reload' from reload.js ajax
  def reload
    @access_token = rest_graph.access_token
    if @access_token
      @user = rest_graph.get('/me')
    end
    @msg_feed = Msg.order("start_time DESC").all
    @msg_feed.each do |msg|
      msg[:start_time] = msg[:start_time].to_i;
      msg[:dead_time] = msg[:dead_time].to_i;
    end

    render :json => {:feed => @msg_feed}.to_json
  end

  #get '/like/:msg_id' from likelol.js ajax
  def like
    @access_token = rest_graph.access_token
    if @access_token
      @user = rest_graph.get('/me')
      @user_id = @user['id']
    end

    @msg_id = params[:msg_id]
    @msg = Msg.find_by_msg_id(@msg_id)
    @msg_like = @msg[:like]

    if ((@msg_like.index(@user_id)).nil?)
      @msg_like.push(@user_id)
    else
      @msg_like.delete(@user_id)
    end

    @msg.update_attribute( :like, @msg_like )
    @msg = Msg.find_by_msg_id(@msg_id)

    render :json => {:msg => @msg}.to_json
  end

  #get '/lol/:msg_id' from likelol.js ajax
  def lol
    @access_token = rest_graph.access_token
    if @access_token
      @user = rest_graph.get('/me')
      @user_id = @user['id']
    end

    @msg_id = params[:msg_id]
    @msg = Msg.find_by_msg_id(@msg_id)
    @msg_lol = @msg[:lol]

    if ((@msg_lol.index(@user_id)).nil?)
      @msg_lol.push(@user_id)
    else
      @msg_lol.delete(@user_id)
    end

    @msg.update_attribute( :lol, @msg_lol )
    @msg = Msg.find_by_msg_id(@msg_id)

    render :json => {:msg => @msg}.to_json
  end

  # get '/user/:id'
  def user
    @id = params[:id]
    user = User.find_by_user_id(@id)
    if(user.nil?)
      redirect_to :action => "index"
    else
      @user_msg = Msg.order("start_time DESC").where( :user_id => @id )
    end

    @user = rest_graph.get('/me')
    current_user = User.find_by_user_id(@user['id'])
    @friends = current_user[:friend_id]

  end

  # get 'msg/:msg_id'
  def msg
  end

  def add
  end

  def create
    @msg = params[:msg]
    @now_time = Time.now
    user = rest_graph.get('/me')
    @user_id = user['id']
    @user_name = user['name']
    @msg_id = @user_id.to_s + "_" + @now_time.to_i.to_s


    if(@msg[:timeSetSelect] == "before")
      @beforeDate = (@msg[:beforeDate]).split('-')
      @dead_time = Time.new(@beforeDate[0], @beforeDate[1], @beforeDate[2], 23, 59, 59)
    elsif(@msg[:timeSetSelect] == "after")
      afterTime = (@msg[:afterTime]).to_i
      if(@msg[:afterTimeUnit] == "minutes")
        @dead_time = @now_time + (60 * afterTime)
      elsif(@msg[:afterTimeUnit] == "hours")
        @dead_time = @now_time + (60 * 60 * afterTime)
      elsif(@msg[:afterTimeUnit] == "days")
        @dead_time = @now_time + (24 * 60 * 60 * afterTime)
      elsif(@msg[:afterTimeUnit] == "weeks")
        @dead_time = @now_time + (7 * 24 * 60 * 60 * afterTime)
      elsif(@msg[:afterTimeUnit] == "months")
        @year = @now_time.year
        @mon = @now_time.mon + afterTime
        while(@mon>12)
            @mon = @mon - 12
            @year = @year + 1
        end
        @dead_time = Time.new(@year,@mon,@now_time.day,@now_time.hour,@now_time.min)
      elsif(@msg[:afterTimeUnit] == "years")
        @year = @now_time.year + afterTime
        @dead_time = Time.new(@year,@now_time.mon,@now_time.day,@now_time.hour,@now_time.min)
      end
    end

    like = Array.new
    lol = Array.new
    vote_yes = Array.new
    vote_no = Array.new

    new_msg = Msg.new(:msg_id => @msg_id,
                      :user_id => @user_id,
                      :user_name => @user_name,
                      :title => @msg[:title],
                      :content => @msg[:content],
                      :start_time => @now_time,
                      :dead_time => @dead_time,
                      :like => like,
                      :lol => lol,
                      :vote_yes => vote_yes,
                      :vote_no => vote_no,
                      :conclusion => "",
                      :color => "#F9F262",
                      :link => @msg[:link]
                      )
    if(new_msg.save)
      redirect_to :action => :index
    else
      redirect_to :action => :index
    end
  end

  def msg_data
    @all_msg = Msg.order("start_time DESC").all
  end

  def login
    redirect_to home_path
  end

  def logout
    reset_session
    redirect_to home_path
  end

  private
  def load_facebook
    rest_graph_setup(:write_session => true)
  end

  def login_facebook
  	scope = []
  	scope << 'read_stream' << 'publish_stream'
    rest_graph_setup(:auto_authorize         => true,
                     :auto_authorize_scope   => scope.join(','),
                     :ensure_authorized      => true,
                     :write_session          => true)
  end
end