require 'tk'
require 'time'

root = TkRoot.new { title "Digital Clock" }
root.geometry = "1000x320"
root.configure(bg: "black")
date_label = TkLabel.new(root) { font "Arial 50"; bg "black"; fg "white"; text "" }
date_label.pack pady: 10
time_label = TkLabel.new(root) { font "Arial 120"; bg "black"; fg "#00ff00"; text "" }
time_label.pack pady: 20

def update
    current_time = Time.now.strftime("%I:%M:%S %p")
    current_date = Time.now.strftime("%d-%B-%Y %A")
    time_label.configure('text', current_time)
    date_label.configure('text', current_date)
    root.after(1000) { update }
end

update
Tk.mainloop
