def alwaysTrue(content):
   return True

def meaning_life(content):
   try:
      return int(content)==42
   except:
      return False

def swallow(content):
   c = content.lower()
   return ("african" in c) and ("european" in c) and ("swallow" in c)

def vigo(content):
   return "vigo" in content.lower()

def star_wars(content):
   c = content.lower()
   return (c == "luke skywalker" or c == "mark hammil")

def frisbee(content):
   try:
      val = float(content)
      return 21 < val < 25
   except:
      return False

def narwhal(content):
   return "midnight" == content.lower()

def jenny(content):
   try:
      return int(content) == 8675309
   except:
      return False

def quine(content):
   return "quine" == content.lower()

events =[
    {
        "question":[
            {"event":"say", "content":"So you think you are the Jesse?"}, 
            {"event":"say", "content":"You must first proove your worth."}, 
            {"event":"say", "content":"..."}, 
            {"event":"ask", "content":"What is your name?"}
        ],
        "correct":[
            {"event":"say", "content":"Interesting...indeed", "imgUrl":"http://images.icanhascheezburger.com/completestore/2008/6/15/thermometer128580142962485736.jpg"}
        ],
        "incorrect":[
        ],
        "verifier":alwaysTrue
    },

    {
        "question":[
            {"event":"ask", "content":"What is the meaning of life and everything?"}
        ],
        "correct":[
            {"event":"say", "content":"Someone appeers to be a nerd", "imgUrl":"http://3.bp.blogspot.com/_5QKKOF-S5mM/TOYrbd91dWI/AAAAAAAAAAM/jrCjx45sFYc/s1600/nerds.jpg"},
            {"event":"say", "content":"You probably even got upset by my spelling errors"}
        ],
        "incorrect":[
            {"event":"say", "content":"Nope"}
        ],
        "verifier":meaning_life
    },

    {
        "question":[
            {"event":"ask", "content":"What is the maximum airspeed of an unladen swallow?"},
            {"event":"say", "content":"And we are not referring to python."}
        ],
        "correct":[
            {"event":"say", "content":"Someone appeers to be a nerd", "imgUrl":"http://3.bp.blogspot.com/_5QKKOF-S5mM/TOYrbd91dWI/AAAAAAAAAAM/jrCjx45sFYc/s1600/nerds.jpg"},
            {"event":"say", "content":"You probably even got upset by my spelling errors"}
        ],
        "incorrect":[
            {"event":"say", "content":"Clue:"},
            {"event":"say", "content":"http://lmgtfy.com"}
        ],
        "verifier":swallow
    },

    {
        "question":[
            {"event":"ask", "content":"Who is your favorite coworker?"}
        ],
        "correct":[
            {"event":"say", "content":"Really..."},
            {"event":"say", "content":"That makes me sad.", "imgUrl":"http://fc08.deviantart.net/fs70/f/2010/149/a/7/Sad_Panda_Chibi_by_mongrelssister.png"}
        ],
        "incorrect":[
        ],
        "verifier":alwaysTrue
    },

    {
        "question":[
            {"event":"ask", "content":"Who is this?", "imgUrl":"http://mos.totalfilm.com/images/7/7-pant-filling-movie-paintings-00.jpg"}
        ],
        "correct":[
            {"event":"say", "content":"Wow that was pretty impressive sleuthing!", "imgUrl":"http://www.getoutdoors.com/goblog/uploads/sleuth.jpg"},
            {"event":"say", "content":"Shall I reward you?"},
            {"event":"say", "content":"Por vu!", "redirect":"http://www.youtube.com/watch?v=dQw4w9WgXcQ&ob=av2e"}
        ],
        "incorrect":[
            {"event":"say", "content":"Clue:"},
            {"event":"say", "content":"Slimer, Janeen, Ray, Egon ..."}
        ],
        "verifier":vigo
    },

    {
        "question":[
            {"event":"say", "content":"Sometimes I just can't help myself"},
            {"event":"ask", "content":"Who is the star of the movie Blue Harvest?"}
        ],
        "correct":[
            {"event":"say", "content":"Not bad", "imgUrl":"http://www.progarchives.com/progressive_rock_discography_covers/364/cover_2213172112008.JPG"}
        ],
        "incorrect":[
            {"event":"say", "content":"Clue:"},
            {"event":"say", "content":"I am your father", "imgUrl":"http://1.bp.blogspot.com/_x0AzhByC-qQ/TB7RvNbgtRI/AAAAAAAACTI/qeeZgVDcDUE/s1600/father.gif"}
        ],
        "verifier":star_wars
    },

    {
        "question":[
            {"event":"ask", "content":"How many seconds would it take a frisbee to fall 1KM on Mars?", "imgUrl":"http://www.shockya.com/news/wp-content/uploads/total_recall_arnold_scream1.jpg"},
            {"event":"say", "content":"ignoring atmospheric effects, of course"}
        ],
        "correct":[
            {"event":"say", "content":"Physics Rocks!", "imgUrl":"http://chzmemebase.files.wordpress.com/2011/05/memes-meanwhile.jpg"}
        ],
        "incorrect":[
            {"event":"say", "content":"Clue:"},
            {"event":"say", "content":"38% gravity aqui"}
        ],
        "verifier":frisbee
    },

    {
        "question":[
            {"event":"ask", "content":"When does the narwhal bacon?"}
        ],
        "correct":[
            {"event":"say", "content":"Who doesn't love Reddit", "imgUrl":"http://i.imgur.com/OJIq2.png"}
        ],
        "incorrect":[
            {"event":"say", "content":"Clue:"},
            {"event":"say", "content":"reddit"}
        ],
        "verifier":narwhal
    },

    {
        "question":[
            {"event":"ask", "content":"What's Jenny's number"}
        ],
        "correct":[
            {"event":"say", "content":"Sing it", "imgUrl":"http://1.bp.blogspot.com/-8ioJ-Gi5fKY/TZLBClWTbhI/AAAAAAAAByg/LlWxkectcR8/s1600/Justin-Bieber.jpg"},
            {"event":"say", "content":"8"},
            {"event":"say", "content":"6"},
            {"event":"say", "content":"7"},
            {"event":"say", "content":"5"},
            {"event":"say", "content":"3"},
            {"event":"say", "content":"0"},
            {"event":"say", "content":"9eee9"}
        ],
        "incorrect":[
            {"event":"say", "content":"Clue:"},
            {"event":"say", "content":"song of course"}
        ],
        "verifier":jenny
    },

    {
        "question":[
            {"event":"say", "content":"What is this python an example of?", "imgUrl":"http://fc00.deviantart.net/fs70/f/2011/041/8/d/the_end_is_nye_by_abornoth-d399rvb.jpg"},
            {"event":"ask", "content":"s=\"s=%s;print s%%`s`\";print s%`s`"}

        ],
        "correct":[
            {"event":"say", "content":"Wow!", "imgUrl":"http://upload.wikimedia.org/wikipedia/commons/8/84/Code_de_la_Bible.png"},
            {"event":"say", "content":"You did it!"},
            {"event":"say", "content":"You must truly be"},
            {"event":"say", "content":"..."},
            {"event":"say", "content":"THE JESSE!!"},
            {"event":"say", "content":"..."},
            {"event":"say", "content":"credits"},
            {"event":"say", "content":"MISCHIEF MOHIT"},
            {"event":"say", "content":"and"},
            {"event":"say", "content":"HOOLIGAN SIEGEL"},
            {"event":"say", "content":"..."},
            {"event":"say", "content":"until next time..."},
            {"event":"say", "content":"..."},
            {"event":"say", "content":"...", "redirect":"http://nyan.cat"}
        ],
        "incorrect":[
            {"event":"say", "content":"Clue:"},
            {"event":"say", "content":"doesn't it's output look strangely similar?"}
        ],
        "verifier":quine
    }
]
