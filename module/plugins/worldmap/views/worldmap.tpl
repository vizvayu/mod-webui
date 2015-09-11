%# No default refresh for this page
%rebase("layout", css=['worldmap/css/worldmap.css'], title='Worldmap', refresh=False)

%setdefault("search_string", "")
%setdefault("common_bookmarks", app.prefs_module.get_common_bookmarks())
%setdefault("user_bookmarks", app.prefs_module.get_user_bookmarks(user))

<!-- HTML map container -->
<div class="map_container">
   %if not hosts:
      <center>
         <h3>We couldn't find any hosts to locate on a map.</h3>
      </center>
      <hr/>
      <p align><strong>1. </strong>If you used a filter in the widget, change the filter to try a new search query.</p>
      <p align><strong>2. </strong>Only the hosts having GPS coordinates may be located on the map. If you do not have any, add hosts GPS coordinates in the configuration file: </p>
      <code>
      <p># GPS</p>
      <p>_LOC_LAT             45.054700</p>
      <p>_LOC_LNG             5.080856</p>
      </code>
   %else:
      <!-- Begin: filter moke-up -->
      <div id="slide-panel">
         <a href="#" class="" id="opener"><i class="fa fa-gear"></i> Options</a>
          
         <div style="overflow-y:auto; max-height:100%; padding:10px; display:none;">
            <h3>Options</h3>     

      <form class="hidden-xs" method="get" action="/all">
        <div class="dropdown form-group text-left">
          <button class="btn btn-default dropdown-toggle" type="button" id="filters_menu" data-toggle="dropdown" aria-expanded="true"><i class="fa fa-filter"></i><span class="hidden-sm hidden-xs hidden-md"> Filters</span> <span class="caret"></span></button>
          <ul class="dropdown-menu" role="menu" aria-labelledby="filters_menu">
            <li role="presentation"><a role="menuitem" href="/all?search=&title=All resources">All resources</a></li>
            <li role="presentation"><a role="menuitem" href="/all?search=type:host&title=All hosts">All hosts</a></li>
            <li role="presentation"><a role="menuitem" href="/all?search=type:service&title=All services">All services</a></li>
            <li role="presentation" class="divider"></li>
            <li role="presentation"><a role="menuitem" href="/all?search=isnot:0 isnot:ack isnot:downtime&title=New problems">New problems</a></li>
            <li role="presentation"><a role="menuitem" href="/all?search=is:ack&title=Acknowledged problems">Acknowledged problems</a></li>
            <li role="presentation"><a role="menuitem" href="/all?search=is:downtime&title=Scheduled downtimes">Scheduled downtimes</a></li>
            <li role="presentation" class="divider"></li>
            <li role="presentation"><a role="menuitem" href="?search=bp:>=5">Impact : {{!app.helper.get_business_impact_text(5, text=True)}}</a></li>
            <li role="presentation"><a role="menuitem" href="?search=bp:>=4">Impact : {{!app.helper.get_business_impact_text(4, text=True)}}</a></li>
            <li role="presentation"><a role="menuitem" href="?search=bp:>=3">Impact : {{!app.helper.get_business_impact_text(3, text=True)}}</a></li>
            <li role="presentation"><a role="menuitem" href="?search=bp:>=2">Impact : {{!app.helper.get_business_impact_text(2, text=True)}}</a></li>
            <li role="presentation"><a role="menuitem" href="?search=bp:>=1">Impact : {{!app.helper.get_business_impact_text(1, text=True)}}</a></li>
            <li role="presentation"><a role="menuitem" href="?search=bp:>=0">Impact : {{!app.helper.get_business_impact_text(0, text=True)}}</a></li>
            <li role="presentation" class="divider"></li>
            <li role="presentation"><a role="menuitem" onclick="display_modal('/modal/helpsearch')"><strong><i class="fa fa-question-circle"></i> Search syntax</strong></a></li>
          </ul>
        </div>
        <div class="form-group">
          <label class="sr-only" for="search">Filter</label>
          <div class="input-group">
            <span class="input-group-addon hidden-xs hidden-sm"><i class="fa fa-search"></i></span>
            <input class="form-control" type="search" id="search_worldmap" name="search_worldmap" value="{{ search_string }}">
          </div>
        </div>
        <div class="dropdown form-group text-left">
          <button class="btn btn-default dropdown-toggle" type="button" id="bookmarks_menu" data-toggle="dropdown" aria-expanded="true"><i class="fa fa-bookmark"></i><span class="hidden-sm hidden-xs hidden-md"> Bookmarks</span> <span class="caret"></span></button>
          <ul class="dropdown-menu dropdown-menu-right" role="menu" aria-labelledby="bookmarks_menu">
            <script type="text/javascript">
               %for b in user_bookmarks:
                  declare_bookmark("{{!b['name']}}","{{!b['uri']}}");
               %end
               %for b in common_bookmarks:
                  declare_bookmarksro("{{!b['name']}}","{{!b['uri']}}");
               %end
            </script>
          </ul>
        </div>
      </form>

         </div>
      </div>
      <!-- End: filter moke-up -->

      <div id="{{mapId}}" class="gMap">
         <div class="alert alert-info">
            <a href="#" class="alert-link">Loading map ...</a>
         </div>
      </div>
   %end
</div>

%include("_worldmap")

<script>
   $(document).ready(function (){
      $('#opener').on('click', function() {
         var panel = $('#slide-panel');
         if (panel.hasClass("visible")) {
            panel.removeClass('visible').animate({'margin-left':'-300px'}, 100, function () {$(this).children('div').hide(100); $(this).css('background-color', 'transparent'); });
         } else {
            panel.css('background-color', '#F0EDE5').addClass('visible').animate({'margin-left':'0px'}, 200, function () {$(this).children('div').show(100); });
         }
         return false;
      });
   });
</script>