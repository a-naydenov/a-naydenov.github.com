#  (c) Etienne Rossignon 
#  Licence : MIT
#  
require 'json'
require 'erb'

class YouTube < Liquid::Tag
  Syntax = /^\s*([^\s]+)(\s+(\d+)\s+(\d+)\s*)?/
  Cache = Hash.new

  def initialize(tagName, markup, tokens)
    super

    if markup =~ Syntax then
      @id = $1

      if $2.nil? then
          @width = 560
          @height = 315 
      else
          @width = $2.to_i
          @height = $3.to_i
      end
    else
      raise "No YouTube ID provided in the \"youtube\" tag"
    end
  end

  def render(context)

    if ( Cache.has_key?(@id)) then 
        return Cache[@id]
    end

    # extract video information using a REST command 
    response = Net::HTTP.get_response("gdata.youtube.com","/feeds/api/videos/#{@id}?v=2&alt=jsonc")
    data = response.body
    result = JSON.parse(data)

    # if the hash has 'Error' as a key, we raise an error
    if result.has_key? 'Error'
        puts "web service error or invalid video id"
    end

    # extract the title and description from the json string
    @title = result["data"]["title"]
    @description = result["data"]["description"]

    puts " title #{@title}"

    @style = "width:100%;height:100%;background:#000 url(http://i2.ytimg.com/vi/#{@id}/0.jpg) center center no-repeat;background-size:contain;position:absolute" 
    
    @emu = "http://www.youtube.com/embed/#{@id}?autoplay=1"

    @videoFrame =  CGI.escapeHTML("<iframe style=\"vertical-align:top;width:100%;height:100%;position:absolute;\" src=\"#{@emu}\" frameborder=\"0\" allowfullscreen></iframe>")
 
    # with jQuery 
    #@onclick    = "$('##{@id}').replaceWith('#{@videoFrame}');return false;"
 
    # without JQuery
    @onclick    = "var myAnchor = document.getElementById('#{@id}');" + 
                  "var tmpDiv = document.createElement('div');" +  
                  "tmpDiv.innerHTML = '#{@videoFrame}';" + 
                  "myAnchor.parentNode.replaceChild(tmpDiv.firstChild, myAnchor);"+
                  "return false;" 

   # note: so special care is required to produce html code that will not be massage by the 
   #       markdown processor :
   #       extract from the markdown doc :  
   #           'The only restrictions are that block-level HTML elements ¿ e.g. <div>, <table>, <pre>, <p>, etc. 
   #            must be separated from surrounding content by blank lines, and the start and end tags of the block
   #            should not be indented with tabs or spaces. '
   result = <<-EOF

<div class="ratio-4-3 embed-video-container-ytube" onclick="#{@onclick}" title="Нажмите для воспроизведения">
<a class="youtube-lazy-link" style="#{@style}" href="http://www.youtube.com/watch?v=#{@id}" id="#{@id}" onclick="return false;">
<div class="youtube-lazy-link-div"></div>
<div class="youtube-lazy-link-info">#{@title}</div>
</a>
<div class="video-info" >#{@description}</div>
</div>

EOF
  Cache[@id] = result
  return result

  end

  Liquid::Template.register_tag "youtube", self
end