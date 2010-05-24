require 'tk'

class GUI
  def initialize(artist, title, tracks)
    @tracks = tracks
    @entry_width = 40 # in characters.
    @entry_height = 25
    @frame_width = 475

    root = TkRoot.new do
      title "ReR Megacorp"
      minsize(500,200)
    end

    title_artist_frame = TkFrame.new do
      relief 'groove'
      borderwidth 1
      pack('pady' => 10)
    end

    TkLabel.new(title_artist_frame) do
      text 'Artist'
      padx 5
      grid('row' => 0, 'column' => 0)
    end
    eartist = TkEntry.new(title_artist_frame)
    vartist = TkVariable.new
    eartist.textvariable = vartist
    vartist.value = artist
    eartist.grid('row' => 0, 'column' => 1)

    TkLabel.new(title_artist_frame) do
      text 'Title'
      padx 5
      grid('row' => 1, 'column' => 0)
    end    
    etitle = TkEntry.new(title_artist_frame)
    vtitle = TkVariable.new
    etitle.textvariable = vtitle
    vtitle.value = title
    etitle.grid('row' => 1, 'column' => 1)

    tracks_frame = TkFrame.new do
      relief 'groove'
      borderwidth 1
      pack
#      place('height' => tracks.size * 34,
#            'width' => 500,
#            'x' => 10,
#            'y' => 70)
    end

    @track_widgets = []

    (0..(tracks.size - 1)).each { |i|
      row = i + 1

      TkLabel.new(tracks_frame) do
        text "Track " + (i+1).to_s
        padx 5
        grid('row' => row, 'column' => 1)
      end
      entry = TkEntry.new(tracks_frame)
      var = TkVariable.new
      entry.textvariable = var
      var.value = tracks[i]
      entry.width = @entry_width
      entry.grid('row' => row, 'column' => 2)
      TkLabel.new(tracks_frame) do
        text "Rip?"
        padx 5
        grid('row' => row, 'column' => 3)
      end
      check_var = TkVariable.new
      check_var.value = 1
      check = TkCheckButton.new(tracks_frame) do
        variable check_var
        padx 5
        grid('row' => row, 'column' => 4)
        command(select)
      end
      check.bind('ButtonPress-1', proc { self.clickCheck(i) })
      @track_widgets += [{ 'entry' => entry, 'check' => check }]
    }

    TkButton.new(root) do
      text 'Dump'
      borderwidth 5
      underline 0
      state 'normal'
      cursor 'watch'
      foreground 'red'
      activebackground 'green'
      relief 'groove'
      command(proc { self.dump })
      pack("side" => "bottom",  "padx"=> "50", "pady"=> "10")
    end
    
    Tk.mainloop
  end
p
  def clickCheck(which)
    puts "checkbox#" + which.to_s + " value: " + @track_widgets[which]['check'].variable.value
    @track_widgets[which]['check'].variable.value = @track_widgets[which]['check'].variable.value == 1 ? 0 : 1
  end

  def dump
    @track_widgets.each { |tw|
      puts tw['entry'].variable.value + "   " + tw['check'].variable.value
    }
  end
end
    
