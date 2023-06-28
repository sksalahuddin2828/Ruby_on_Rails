require 'tk'
require 'time'
require 'date'

root = TkRoot.new { title "Sk. Salahuddin - Morning 01 Batch" }
root.geometry = "500x200"
root.configure(bg: "#202020")
date_label = TkLabel.new(root) { font "Arial 24"; bg "#202020"; fg "#fff"; text "" }
date_label.pack pady: 10
time_label = TkLabel.new(root) { font "Arial 60"; bg "#202020"; fg "#f0f"; text "" }
time_label.pack pady: 20

def update
    current_time = Time.now.strftime("%I:%M:%S %p")
    current_date = Time.now.strftime("%A, %B %d, %Y")
    time_label.configure('text', current_time)
    date_label.configure('text', current_date)
    root.after(1000) { update }
end

update
Tk.mainloop
