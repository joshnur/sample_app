

class PagesController < ApplicationController

  
  def contact
      @title = "Contact"
  end

  def about
    @title = "About"
  end

  def home
   
     @tweetsSim=
            [{:user1 => "Oracle sues Google over Android I.P. $ORCL $GOOG http://www.ft.com"},
             {:user2 => "HP ousts CEO Mark Hurd http://www.abc.com $HPQ"},
             {:user3 => "SEC files civil lawsuit against Goldman Sachs http://www.sec.com $GS"},
             {:user4 => "7.5 magnitude Earthquake strikes southern Taiwan http://www.news.google/5455/"},
             {:user5 => "BP Oil Rig Deepwater Horizon explosion causes massive oil spill in Gulf of Mexico http://bit.ly/345435"},
             {:user6 => "Apple launches iPhone in China http://ft.com/apple-launches-iPhone4-in-China"},
             {:user7 => "Microsoft announces Windows 7 Phone specifications, manufacturing & development partners http://bit.ly/344737"}
            ]

     @cleanText=
            ["Oracle sues Google over Android I.P.",
             "HP ousts CEO Mark Hurd",
             "SEC files civil lawsuit against Goldman Sachs",
             "7.5 magnitude Earthquake strikes southern Taiwan",
             "BP Oil Rig Deepwater Horizon explosion causes massive oil spill in Gulf of Mexico",
             "Apple launches iPhone in China",
             "Microsoft announces Windows 7 Phone specifications, manufacturing & development partners"
            ]

       @urls=
            ["http://www.ft.com",
             "http://www.abc.com",
             "http://www.sec.com",
             "http://www.news.google/5455/",
             "http://bit.ly/345435",
             "http://ft.com/apple-launches-iPhone4-in-China",
             "http://goo.gl/87876"
            ]

       @geoTags=
         [

         ]

    #require "rubygems"

    # Parsing XML from the net

    require 'net/http'
    require 'rexml/document'
    #require 'sqlite3'

    # Open Database
    #db = SQLite3::Database.new("tst2.sqlite")

    #---------------------
    # StockTwits
    #--------------------

    # StockTwits API URL (can be refreshed every minute or so)
    url = 'http://stocktwits.com/streams/all.xml'

    # get the XML data as a string
    xml_data = Net::HTTP.get_response(URI.parse(url)).body

    # extract event information
    doc = REXML::Document.new(xml_data)
    tweets = []
    tickers = []
    times=Time.now

    doc.elements.each('stream/tweets/tweet/tweet_text') do |ele|
       tweets << ele.text
    end
    doc.elements.each('stream/tweets/tweet/stocks/stock/ticker') do |ele|
       tickers << ele.text
    end
    
   # @foo = StockTwit::Frequency.execute

    # Analyze all tweets
   # tweets.each_with_index do |tweet, idx|
     #   print "#{tweet}\n" #print "#{tweet} => #{links[idx]}\n"


      # get Semantic Analysis - OpenCalais
    #end

    # print all tickers
    #tickers.each_with_index do |ticker, idx|
    #   print "#{ticker}\n"#   print "#{tweet} => #{links[idx]}\n"
    #end


    # StockTwits Ticker Frequency Analysis
    @freqs= Hash.new(0)
    tickers.each { |ticker| @freqs[ticker] += 1 }
    @freqs = @freqs.sort_by {|x,y| y }
    @freqs.reverse!

    render

    #return @freqs
    #rowid=0

#    @freqs.each do |ticker, freq|
#      puts ticker + ': ' + freq.to_s
      #Add to database
      #db.execute( "insert into t1(times, ticker, freq) values('#{times}', '#{ticker}', '#{freq}')")
#      rowid+=1
#    end


    #rows = db.execute( "insert ticker, freq, timestamp into t2")
      end
end
