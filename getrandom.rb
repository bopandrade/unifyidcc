#!/usr/bin/env ruby

require 'net/http'




def getThreeBytesArray(num = 8192)
    uri1 = URI('https://www.random.org/integers/?min=0&max=16777215&col=1&base=16&format=plain&rnd=new&num=' + num.to_s)


    res1 = Net::HTTP.get_response(uri1)
    if res1.is_a?(Net::HTTPSuccess)
        o = res1.body.split(/\n/)
        o.each do |x|
            x.gsub!(/(..)/, '\x\1')
        end
       return o 
    else
       puts "quota exceeded"
       return []
    end
end


bmp = "\x42\x4d\x36\xc0\x00\x00\x00\x00\x00\x00\x36\x00\x00\x00\x28\x00\x00\x00\x80\x00\x00\x00\x80\x00\x00\x00\x01\x00\x18\x00\x00\x00\x00\x00\x00\xc0\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"

firstHalf =  getThreeBytesArray
secondHalf =  getThreeBytesArray

bmp += firstHalf.join + secondHalf.join

File.open('bopandrade.bmp', 'w') { |f| f.write(bmp) }
