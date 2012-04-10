# this script takes the tiles generated by Krpano and renames them to work with the iip protocol
# krpano kmaketiles command
# Example: input.tiff is  8504x5220
# we generate tiles for 4 levels of resolution, 4,5,6,7
# kmaketiles input.tiff out/4/tiles_4_%v_%u.jpg 256 -resize=1063x652.5
# kmaketiles input.tiff out/5/tiles_5_%v_%u.jpg 256 -resize=2126x1305
# kmaketiles input.tiff out/6/tiles_6_%v_%u.jpg 256 -resize=4252x2610
# kmaketiles input.tiff out/7/tiles_7_%v_%u.jpg 256

require 'fileutils'


path = "imgtest/out/"
puts path
sets = Hash["4" => 5, "5" => 9, "6" => 17, "7" => 34]

Dir.new(path).entries.each do |level|
    if level != ".." && level != "." && level != ".DS_Store" && File.directory?(path+level)
      counter = 0
      images = Dir.new(path+level).entries
      images.sort!
      images.each do |image|
        if image != ".." && image != "." && image != ".DS_Store"
          n =  image.split('.jpg')[0]
          n = n.split('tiles_')[1]
          arr =  n.split('_')
          #sum = (level.to_i)*(arr[0].to_i-1) + arr[1].to_i + (arr[0].to_i-1) - 1
          sum = (arr[1].to_i-1) * sets[level.to_s].to_i + arr[2].to_i - 1
          #puts n + "\t" + sum.to_s + "\t" + arr[1].to_s + "\t" + arr[2].to_s
          f = "tiles_" + level  + "_" + sum.to_s + ".jpg"
          File.rename(path+level+"/"+image, path+level+"/"+f)
        end
      end
      puts "-----"
    end
end

