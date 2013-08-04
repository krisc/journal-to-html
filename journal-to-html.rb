puts "Converting journal entries to html..."
@@dir = "~/doc/writings/" # You can change this directory to whatever you want
@@months = { '00' => 'Month',
           '01' => 'January',
           '02' => 'February',
           '03' => 'March',
           '04' => 'April',
           '05' => 'May',
           '06' => 'June',
           '07' => 'July',
           '08' => 'August',
           '09' => 'September',
           '10' => 'October',
           '11' => 'November',
           '12' => 'December' }

def html_gen ( entry, date, dates )
  if entry.class != String
    raise Exception, "Not valid entry!"
  else
    # strip date into pieces
    year = date[-8, 4]
    month = @@months[ date[-4, 2] ]
    day = date[-2, 2]

    # gen code for sidebar navigation
    sidebar = ""
    dates.each do |d|
      s_year = d[-8, 4]
      s_month = @@months[ d[-4, 2] ]
      s_day = d[-2, 2]
      sidebar << "<a href=\"" + d + ".html\">" + s_month + " " + s_day + ", " + s_year + "</a><br>"
    end
  
    # gen code for prev and next navigation
    i_entry = dates.index(date)
    i_prev = i_entry > 0 ? i_entry - 1 : dates.length - 1
    i_next = i_entry == dates.length - 1 ? 0 : i_entry + 1
    puts dates[i_prev]

    # gen code for main body of page
    temp1 = "<html><body><h1>Journal: " + month + " " + day + ", " + year +
            "</h1><table width=\"100%\"><tr><td width=\"10%\"><font size=\"2\">"
    temp2 = "</font></td><td valign=\"top\" width=\"80%\">"
    navi  = "<p><a href=\"" + dates[i_prev] + ".html\">" + "Previous " + "</a><a href=\"" + dates[i_next] + ".html\">" + " Next</a>"
    temp3 = "</td></tr></body></html>"
    
          
    # make an html directory 
    #`mkdir ./html/` if `ls ./html/`==""
    # NOTE: this script only works when your in the current directory of
    #       journal files

    # create an html file
    File::open( date + ".html", "w" ) do |f|
      f << temp1 + sidebar + temp2 + navi + "<br><br>" + entry + "<br><br>" + navi + temp3
    end
  end
end

def gen_all ( entries )
  dates = []

  dates = entries.delete_if {|entry| entry.include? "~"}
  dates = entries.delete_if {|entry| entry.include? ".html"}

  #puts dates

  # read a journal file, substitute \n with <br>'s, then generate html for
  # that entry
  dates.each do |date|
    next unless date
    f = File::read( date )
    f = f.gsub "\n", '<br>'
    html_gen f, date, dates
  end
end

gen_all ARGV
puts "Done!"
