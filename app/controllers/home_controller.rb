# app/controller/home.rb
class HomeController < ApplicationController
  include RestGraph::RailsUtil
  before_filter :login_facebook, :only => [:login]
  before_filter :load_facebook, :except => [:login]

  def index
    @access_token = rest_graph.access_token

    if @access_token
      @user = rest_graph.get('/me')
      @user_friend = rest_graph.get('/me/friends')
    else
      render 'out.html.erb'
    end
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
  	scope << 'publish_checkins' << 'publish_stream'
    rest_graph_setup(:auto_authorize         => true,
                     :auto_authorize_scope   => scope.join(','),
                     :ensure_authorized      => true,
                     :write_session          => true)
  end
end