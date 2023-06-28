require 'tk'

master = TkRoot.new { title "Digital Clock" }

def get_time(clock)
    timeVar = Time.now.strftime("%H:%M:%S %p")
    clock.configure('text', timeVar)
    clock.after(200) { get_time(clock) }
end

TkLabel.new(master) { font "Arial 30"; text "Digital Clock"; fg "white"; bg "black" }.pack
clock = TkLabel.new(master) { font "Arial 100"; bg "black"; fg "white" }
clock.pack

get_time(clock)
Tk.mainloop
