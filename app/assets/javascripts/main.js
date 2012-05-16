$(function(){
	console.log("Javascript Work correctly.");
	if(window.innerWidth>600){

		function HiddenShow(id){
			var state = document.getElementById(id).style.display;
			if (state == 'block') {
				document.getElementById(id).style.display = 'none';
			} else{
				document.getElementById(id).style.display = 'block';
			}
		};

		function SelectFunction(){
			if($('select.timeSetSelect').val()=="before"){
				//document.getElementById('TimeSetToAfter').style.display = 'none';
				//document.getElementById('TimeSetToBefore').style.display = 'block';
				document.frm.TimeUnit.disabled = true;
				$('#date').datepicker();
			}else{
				document.frm.TimeUnit.disabled = false;
				$('#date').removeClass('hasDatepicker');
				//document.getElementById('TimeSetToAfter').style.display = 'block';
				//document.getElementById('TimeSetToBefore').style.display = 'none';
			};
		}
		
		$('div.feedicon').on('hover',function(){
			console.log("I am here");
			$('div.feeditem').show('clip');
		// $('div.feeditem').css('display', 'block');
		// document.getElementById('TitleMenuStatus').style.display = 'none';
		});

		$('body').on('click',function(){
			document.getElementById('TitleMenuStatus').style.display = 'none';
			$('div.feeditem').hide();
		});

		$('div.title div.logo').on('hover',function(){
			document.getElementById('TitleMenuStatus').style.display = 'block';
		});
		$('div.add').on('click',function(){
			HiddenShow('addPostStatus');
		});
		$('div.addPost input.destroy').on('click',function(){
			HiddenShow('addPostStatus');
		});
		$('li.friendList').on('click',function(){
			HiddenShow('friendListStatus');
		});
		$('div.friendList input.destroy').on('click',function(){
			HiddenShow('friendListStatus');
		});
		
		SelectFunction();
		$('select.timeSetSelect').on('change',function(){
			SelectFunction();
		});
		
		$('input.date').on('click',function(){
			document.getElementById('date').value = "";
		});
		$('input.title').on('click',function(){
			document.getElementById('title').value = "";
		});
		
	}else{
		
	};


});


