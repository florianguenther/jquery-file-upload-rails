
class Jquery < Thor
  include Thor::Actions
  
  @@raw_url = "https://github.com/blueimp/jQuery-File-Upload/raw/master/"
  @@asset_root = File.join File.dirname(__FILE__), "../assets"
  @@folder = "jquery-file-upload"
  
  desc 'update', 'update from original repository'
  def update
    asset_gsub = []
    
    %w[fileupload.js fileupload-ui.js iframe-transport.js].each do |js|
      target = File.join(@@asset_root, "javascripts", @@folder, js)
      get "#{@@raw_url}jquery.#{js}", target
    end

    %w[fileupload-ui.css].each do |css|
      asset_gsub << target = File.join(@@asset_root, "stylesheets", @@folder, css)
      get "#{@@raw_url}jquery.#{css}", target
    end

    %w[loading.gif pbar-ani.gif].each do |img|
      get "#{@@raw_url}#{img}", File.join(@@asset_root, "images", @@folder, img)
      asset_gsub.each do |file|
        gsub_file file, /(#{img})/, "#{@@folder}/#{img}"
      end
    end
    
    # get jQuery Template Plugin
    get "https://github.com/jquery/jquery-tmpl/raw/master/jquery.tmpl.js", File.join(@@asset_root, "javascripts", @@folder, "jquery.tmpl.js")
  end
  
end