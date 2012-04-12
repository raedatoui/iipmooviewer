require 'fastimage'
require 'image_size'


file = ARGV[0]
output = ARGV[1]

open(file, "rb") do |fh|
  d = ImageSize.new(fh.read).get_size
  @width  = d[0]
  @height = d[1]
end

steps ={"3"=> 16,"4"=> 8,"5"=> 4,"6"=> 2,"7"=>1}
counts = {"3"=> 16,"4"=> 8,"5"=> 4,"6"=> 2,"7"=>1}
steps.each do |k,v|
	puts k
	command = "./tools/kmaketiles " + file + " " + output + "/"+k+"/tiles_"+k+"_%v_%u.jpg 256 -resize=" + (@width.to_f/v.to_f).round.to_s + "x" + (@height.to_f/v.to_f).round.to_s
	puts command
	system command
	puts "---"
	Dir.chdir(output+'/'+k)
	files = Dir.glob("tiles_"+k+"_1_*")
	counts[k] = files.length
	Dir.chdir('../../')
end
puts counts.inspect
system "ruby fixfiles.rb " + output + " " + counts["3"].to_s + " " + counts["4"].to_s + " " + counts["5"].to_s + " " + counts["6"].to_s + " " + counts["7"].to_s