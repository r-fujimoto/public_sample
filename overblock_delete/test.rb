
MAX_BLOCK_LINE = 5
REM_BLOCK_LINE = 2


def write_block(buf, ofile)
  del_count = buf.size - 2 * REM_BLOCK_LINE - 1
  File.open(ofile, "a") {|f|
    if del_count > 0
      f.puts buf[0..REM_BLOCK_LINE]
      f.puts "..." + del_count.to_s + " lines deleted for printing..."
      f.puts buf[-REM_BLOCK_LINE..buf.size]
    else
      f.puts buf
    end
  }
end

def read_file(in_file, out_file)
  File.open(in_file,"r") {|f|
    buf_read = []
    while line = f.gets
      if line =~ /^\[.+\]/ && buf_read.length > 0
          write_block(buf_read, out_file)
  	buf_read = []
      end
      buf_read.push(line)
    end
    write_block(buf_read, out_file)
  }
end

unless ARGV.length == 2
  print "usage: test.rb <input file> <output file>\n\n"
  exit
end

read_file(ARGV[0], ARGV[1])
