require 'tk'
require 'time'
require 'date'

root = TkRoot.new {title "Digital Clock"}
root.geometry = "700x370"
root.configure(bg: "#272727")
date_formats = ["%B %d, %Y"]
#"%d-%m-%Y",
#"%b %d, %Y",
# "Today is %A, %B %d, %Y",
# "Happy %A, %B %d, %Y",
# "It's %A, %B %d, %Y",
# "The date is %A, %B %d, %Y"
date_format = date_formats[0]
date_label = TkLabel.new(root) { font "Helvetica 35"; bg "#272727"; fg "#fff"; text "" }
date_label.pack pady: [30, 10]
time_label = TkLabel.new(root) { font "Helvetica 80 bold"; bg "#272727"; fg "#F39C12"; text "" }
time_label.pack pady: 10
day_of_week_label = TkLabel.new(root) { font "Helvetica 18"; bg "#272727"; fg "#fff"; text "" }
day_of_week_label.pack
month_label = TkLabel.new(root) { font "Helvetica 18"; bg "#272727"; fg "#fff"; text "" }
month_label.pack
year_label = TkLabel.new(root) { font "Helvetica 18"; bg "#272727"; fg "#fff"; text "" }
year_label.pack

def update
    current_time = Time.now.strftime("%I:%M:%S %p")
    current_date = Time.now.strftime(date_format)
    day_of_week = Date.today.strftime("%A")
    month = Date.today.strftime("%B")
    year = Time.now.strftime("%Y")
    time_label.configure('text', current_time)
    date_label.configure('text', current_date)
    day_of_week_label.configure('text', day_of_week)
    month_label.configure('text', month)
    year_label.configure('text', year)
    root.after(1000) { update }
end

update
Tk.mainloop
