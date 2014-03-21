%rebase layout globals(), js=['dashboard/js/widgets.js', 'dashboard/js/jquery.easywidgets.js'], css=['dashboard/css/dashboard.css'], title='Dashboard', menu_part='/dashboard', refresh=True

%from shinken.bin import VERSION
%helper = app.helper

<script type="text/javascript">
  /* We are saving the global context for theses widgets */
  widget_context = 'dashboard';
</script>

<!-- Maybe the admin didn't add a user preference module, or the module is dead, if so, warn about it -->
%if not has_user_pref_mod:
<div id="warn-pref" class="hero-unit alert-critical">
  <h2>Warning:</h2>
  <p>You didn't define a WebUI module for saving user preferences like the MongoDB one. You won't be able to use this page!</p>
  <p><a href="http://www.shinken-monitoring.org/wiki/shinken_10min_start" class="btn btn-success">Learn more <i class="icon-hand-right"></i></a></p>
</div>
%end

<div class="row">
	<ul id="Navigation" class="col-sm-12">
		<li class="col-sm-1"></li>
		
		<li class="col-sm-2">
			<a href="/problems" class="btn btn-sm"><i class="icon-plus" style="color: #333"></i>
				<svg version="1.0" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="50px" height="42px" viewBox="0 0 100 83.419" enable-background="new 0 0 100 83.419" fill="#333" xml:space="preserve">
					<path fill-opacity="0.875" d="M68.2,55.555l4.742,4.792c6.451-6.143,10.461-14.861,10.461-24.532c0-9.521-3.901-18.122-10.184-24.25
					l-5.159,5.356c5.06,4.861,8.228,11.724,8.228,19.317C76.288,43.797,73.217,50.701,68.2,55.555z"></path>
					<path fill-opacity="0.875" d="M56.625,43.85l5.856,5.923c3.591-3.371,5.857-8.176,5.857-13.535c0-5.425-2.322-10.297-5.996-13.676
					l-5.858,6.063c2.083,1.862,3.486,4.559,3.486,7.613C59.971,39.257,58.664,41.993,56.625,43.85z"></path>
					<path fill-opacity="0.875" d="M20.082,7.333l-5.996-6.063C5.388,10.352,0,22.63,0,36.237c0,13.575,5.286,25.895,13.945,34.967
					l6.137-6.203C12.987,57.483,8.646,47.283,8.646,36.097C8.646,24.914,12.987,14.819,20.082,7.333z"></path>
					<path fill-opacity="0.875" d="M78.66,66.129l6.137,6.202C94.124,63.162,100,50.43,100,36.237C100,21.979,94.071,9.186,84.658,0
					L78.66,6.064c7.797,7.588,12.691,18.201,12.691,30.032C91.352,47.896,86.418,58.51,78.66,66.129z"></path>
					<path fill-opacity="0.875" d="M25.661,12.972c-5.5,6.013-8.926,14.014-8.926,22.843c0,9.017,3.499,17.218,9.205,23.266l4.742-4.796
					c-4.303-4.749-6.974-11.085-6.974-18.047c0-6.996,2.628-13.424,6.974-18.19L25.661,12.972z"></path>
					<path fill-opacity="0.875" d="M42.258,42.583c-1.398-1.747-2.23-3.93-2.23-6.346c0-2.48,0.897-4.718,2.371-6.486l-5.858-5.779
					c-2.938,3.268-4.882,7.514-4.882,12.265c0,4.718,1.84,9.005,4.743,12.268L42.258,42.583z"></path>
					<path d="M45.838,36.237c0,2.324,1.865,4.208,4.16,4.208c2.298,0,4.159-1.884,4.159-4.208c0-2.321-1.861-4.204-4.159-4.204
					C47.703,32.033,45.838,33.917,45.838,36.237z"></path>
					<path fill-opacity="0.875" d="M45.313,46.234L34.497,83.419h30.286L53.966,46.234C51.102,46.874,48.226,47.098,45.313,46.234z"></path>
				</svg>
				<span class="badger-title itproblem">IT Problems</span>
				%if app:
					%overall_itproblem = app.datamgr.get_overall_it_state()
					%if overall_itproblem == 0:
					<span class="badger-big badger-ok">OK!</span>
					%elif overall_itproblem == 1:
					<span class="badger-big badger-warning">{{app.datamgr.get_nb_all_problems(user)}}</span>
					%elif overall_itproblem == 2:
					<span class="badger-big badger-critical">{{app.datamgr.get_nb_all_problems(user)}}</span>
					%end
				%end
			</a>
		</li>

		<li class="col-sm-2">
			<a href="/impacts" class="slidelink btn btn-sm"><i class="icon-plus" style="color: #333"></i>
				<svg version="1.0" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="50px" height="42px" viewBox="0 0 100 82.922" enable-background="new 0 0 100 82.922" fill="#333" xml:space="preserve">
					<path d="M77.958,11.073c-3.73,0-7.339,0.933-10.544,2.685C63.515,5.537,55.108,0,45.693,0C32.842,0,22.314,10.141,21.694,22.838
					c-5.901,0.704-10.96,4.619-13.149,10.09C3.642,34.151,0,38.595,0,43.873c0,6.223,5.062,11.283,11.281,11.283h27.821l-4.238,8.501
					h6.463L28.781,82.922l32.948-23.357l-10.714-0.128l4.004-4.28h22.938c12.154,0,22.042-9.891,22.042-22.042
					C100,20.961,90.112,11.073,77.958,11.073z M77.958,47.375H11.281c-1.932,0-3.502-1.571-3.502-3.502c0-1.904,1.532-3.46,3.43-3.502
					c0.062,0.006,0.125,0.009,0.188,0.012l3.291,0.107l0.65-3.229c0.787-3.915,4.266-6.757,8.266-6.757c0.481,0,0.978,0.044,1.474,0.131
					l5.257,0.924l-0.73-5.284c-0.104-0.766-0.157-1.521-0.157-2.249c0-8.958,7.289-16.244,16.247-16.244
					c7.695,0,14.391,5.462,15.917,12.988l1.405,6.906l5.097-4.871c2.667-2.545,6.163-3.95,9.846-3.95c7.865,0,14.26,6.398,14.26,14.26
					S85.823,47.375,77.958,47.375z"/>
				</svg>
				<span class="badger-title impacts">Impacts</span>
				%if app:
					%overall_state = app.datamgr.get_overall_state()
					%if overall_state == 0:
					<span class="badger-big badger-ok">Ok</span>
					%elif overall_state == 2:
					<span class="badger-big badger-critical">{{app.datamgr.get_len_overall_state()}}</span>
					%elif overall_state == 1:
					<span class="badger-big badger-critical">{{app.datamgr.get_len_overall_state()}}</span>
					%end
				%end
			</a>
		</li>

		<li class="col-sm-2">
			<a href="/services" class="slidelink btn btn-sm"><i class="icon-plus" style="color: #333"></i>
				<svg version="1.0" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="50px" height="42px" viewBox="0 0 100 82.922" enable-background="new 0 0 100 82.922" fill="#333" xml:space="preserve">
					<path fill-rule="evenodd" clip-rule="evenodd" d="M17.15,47.28V85.2l31.601,13.543v-37.92L17.15,47.28z M84,45.437  L49.653,60.823v37.92L84,83.357V45.437z M61.458,2.445l-33.466,14.83v32.759l9.043,3.747l-0.022-22.753  c0,0,12.31-5.395,24.445-10.691V2.445z M22.575,15.695L22.56,47.784l4.507,1.865V17.485L22.575,15.695z M22.936,14.311l4.484,1.791  l32.759-14.28L55.665,0L22.936,14.311z M38.818,54.525l4.5,1.866V35.543l-4.492-1.791L38.818,54.525z M44.243,56.775l5.41,2.242  l28.057-12.52V20.502l-33.467,14.83V56.775z M39.188,32.368l4.484,1.791l32.76-14.28l-4.515-1.821L39.188,32.368z"/>
				</svg>
				<span class="badger-title services">Services OK</span>
				%if app:
					%service_state = app.datamgr.get_per_service_state()
					%if service_state <= 0:
					<span class="badger-big badger-critical">{{app.datamgr.get_per_service_state()}}%</span>
					%elif service_state <= 33:
					<span class="badger-big badger-critical">{{app.datamgr.get_per_service_state()}}%</span>
					%elif service_state <= 66:
					<span class="badger-big badger-warning">{{app.datamgr.get_per_service_state()}}%</span>
					%elif service_state <= 100:
					<span class="badger-big badger-ok">{{app.datamgr.get_per_service_state()}}%</span>
					%end
				%end
			</a>
		</li>

		<li class="col-sm-2">
			<a href="/hostgroups" class="slidelink btn btn-sm"><i class="icon-plus" style="color: #333"></i>
				<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" id="Layer_1" x="0px" y="0px" width="50px" height="42px" viewBox="0 0 50 50" enable-background="new 0 0 50 50" fill="#333" xml:space="preserve">
				<polygon points="45.91,26.078 40.467,26.078 40.467,44.177 25.517,44.177 25.517,34.844 16.105,34.844 16.105,44.177 8.73,44.177   8.732,26.078 3.687,26.078 24.596,5.168 "/>
				</svg>
				<span class="badger-title hosts">Hosts UP</span>
				%if app:
					%service_state = app.datamgr.get_per_hosts_state()
					%if service_state <= 0:
					<span class="badger-big badger-critical">{{app.datamgr.get_per_hosts_state()}}%</span>
					%elif service_state <= 33:
					<span class="badger-big badger-critical">{{app.datamgr.get_per_hosts_state()}}%</span>
					%elif service_state <= 66:
					<span class="badger-big badger-warning">{{app.datamgr.get_per_hosts_state()}}%</span>
					%elif service_state <= 100:
					<span class="badger-big badger-ok">{{app.datamgr.get_per_hosts_state()}}%</span>
					%end
				%end
			</a>
		</li>

		<li class="col-sm-2">
			%# If we got no widget, we should put the button at the center fo the screen
			%small_show_panel_s = ''
			%if len(widgets) == 0:
			%small_show_panel_s = 'hide'
			%end
			<a id="small_show_panel" data-toggle="modal" href="#widgets" class="slidelink btn btn-sm btn-success pull-right {{small_show_panel_s}}"><i class="icon-plus"></i> Add a new widget</a>
		</li>
		
		<li class="col-sm-1"></li>
	</ul>
</div>

<button type="button" class="btn btn-default" data-container="body" data-toggle="popover" data-placement="bottom" data-content="Vivamus
sagittis lacus vel augue laoreet rutrum faucibus.">
  Popover on bottom
</button>

%# Go in the center of the page!
<div id="loading" class="pull-left"> <img src='/static/images/spinner.gif'> Loading widgets</div>
<span id="center-button" class="col-sm-4 col-sm-offset-4 page-center" >
	<h3>You don't have any widget yet?</h3>
	<!-- Button trigger widgets modal -->
	<a data-toggle="modal" href="#widgets" class="btn btn-block btn-success btn-lg"><i class="icon-plus"></i> Add a new widget</a>
</span>

<script>
  // Now load all widgets
  $(function(){
    %for w in widgets:
    %if 'base_url' in w and 'position' in w:
    %uri = w['base_url'] + "?" + w['options_uri']
    AddWidget("{{!uri}}", "{{w['position']}}");
    %end
    %end
  });
</script>

<div class="modal fade" id="widgets" tabindex="-1" role="dialog" aria-labelledby="Widgets" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<span class="icon"><i class="fa fa-signal"></i></span>
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title">Available widgets</h4>
			</div>

			<div class="modal-body">
				%for w in app.get_widgets_for('dashboard'):
				<button type="button" class="btn btn-block" style="margin-bottom: 2px;" data-toggle="collapse" data-target="#desc_{{w['widget_name']}}">
				  {{w['widget_name']}}
				</button>

				<div id="desc_{{w['widget_name']}}" class='widget_desc collapse' >
					<div class="row">
						<span class="col-sm-6">
							<img class="img-rounded" style="width:100%" src="{{w['widget_picture']}}" id="widget_desc_{{w['widget_name']}}"/>
						</span>
						<span>{{!w['widget_desc']}}</span>
					</div>
					<p class="add_button"><a class="btn btn-sm btn-success" href="javascript:AddNewWidget('{{w['base_uri']}}', 'widget-place-1');"> <i class="icon-chevron-left"></i> Add {{w['widget_name']}} widget</a></p>
				</div>
				%end
			</div>
			
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<div class="widget-place" id="widget-place-1"> </div>
<!-- /place-1 -->

<div class="widget-place" id="widget-place-2"> </div>
<!-- /place-2 -->

<div class="widget-place" id="widget-place-3"> </div>
<!-- /place-3 -->


<!-- End Easy Widgets plugin HTML markup -->

<!-- Bellow code not is part of the Easy Widgets plugin HTML markup -->

