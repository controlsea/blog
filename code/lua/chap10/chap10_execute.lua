--learning lua
--chap 10

--读.lua文件，生成.html文件

function fwrite(fmt,...)
	return io.write(string.format(fmt,...))
end

function writeHTTPHeader()
	io.write([[<html>
			   <head><title>projects using lua</title></head>
			   <body bgcolor="#FFFFFF">
			   Here are some brief descriptions of some projects around the world that use lua
			   <br></br>
	]])
end

function writeHTTPBody()
	fwrite('</body></html>\n')
end

function entry1(o)
	count = count + 1
	local title = o.title or '(no title)'
	fwrite('<li><a href="#%d">%s</a>\n',count,title)
end

function entry2(o)
	count = count + 1
	fwrite('<hr>\n<h3>\n')
	local href = o.url and string.format('href= "%s"',o.url) or ''
	local title = o.title or o.org or 'org'
	fwrite('<a name = "%d"%s>%s</a>\n',count,href,title)
	
	if o.title and o.org then
		fwrite('<br>\n<small><em>%s</em></small>',o.org)
	end
	
	fwrite('\n</h3>\n')
	
	if o.description then
		fwrite('%s<p>\n',string.gsub(o.description,'\n\n+','<p>\n'))
	end
	
	if o.contact then
		fwrite('contact:%s\n',o.contact)
	end
end

local filename = './chap10_input.lua'
writeHTTPHeader()

count = 0
local f = assert(loadfile(filename))

entry = entry1
fwrite('<ul>\n')
f()
fwrite('</ul>\n')

count = 0
entry = entry2
f()

writeHTTPBody()
