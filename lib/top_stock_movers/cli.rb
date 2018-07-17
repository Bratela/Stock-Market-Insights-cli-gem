class TopStockMovers::CLI

  def call
    list_viewing_options
    list_stocks
    menu
    goodbye
  end

# This Viewing_options class is what is used to allow the program to view the 7 different sorting options
# from the website and is the information used to populate the first list selection. It also is what is used
# to provide the most relevant information and sorting options for the list_stocks method.
  class Viewing_options
    attr_accessor :name, :desc, :sorter

    @@all = []

    def self.all
      @@all
    end

    viewing_options = [["Gainers", "Stocks that have increased the most in price", "percent_change-pos"], ["Losers", "Stocks that have lost most of their value", "percent_change-neg"], ["Active" , "Stocks that have been traded the most", "volume"],  ["Most-Volatile", "The fluctuation of price in any given timeframe", "percent_change-abs"],  ["Overbought", "Stocks that significantly increased in price due a large demand", "rating"], ["Oversold", "Stock prices have decreased substantially", "rating"], ["Large-Cap", "Largest companies by market cap", "market_cap"]]

    viewing_options.each do |array|
      option = self.new
        option.name = array[0]
        option.desc = array[1]
        option.sorter = array[2]
        @@all << option
    end
  end

  @selection = nil

  def list_viewing_options
    puts ""
    puts "How would you like to view today's Stock Market?? please enter corresponding number"
    puts ""
    Viewing_options.all.each.with_index(1) do |option, i|
      puts "#{i}. #{option.name} -- #{option.desc}"
    end
    input = gets.strip.to_i - 1
    @selection = Viewing_options.all[input]
  end

  def list_stocks
    puts ""
    puts "Today's Top 25 #{@selection.name} stocks"
    puts "------------------------------"

    #The line below allows me to scrape 7 different url's by changing the url according to the users selection
    TopStockMovers::Stocks.scrape_tradingview(@selection.name.downcase) if TopStockMovers::Stocks.all == []
    @stocks = TopStockMovers::Stocks.all
    #This case statement is using the Viewing_options instance originally selected by the user to output
    #the most relevant data per the selection and sorts accordingly. For example "% change" for Gainers, or "volume" for Active
    case @selection.sorter
    when "percent_change-pos"
      @stocks.sort{|a,b| b.percent_change <=> a.percent_change}.each.with_index(1) do |stock, i|
        puts "#{i}. #{stock.percent_change}% - #{stock.ticker_symbol} - #{stock.name}"
        break if i == 25
      end
    when "percent_change-neg"
      @stocks.sort{|a,b| a.percent_change <=> b.percent_change}.each.with_index(1) do |stock, i|
        puts "#{i}. #{stock.percent_change}% - #{stock.ticker_symbol} - #{stock.name}"
        break if i == 25
      end
    when "percent_change-abs"
      @stocks.sort{|a,b| b.percent_change.abs <=> a.percent_change.abs}.each.with_index(1) do |stock, i|
        puts "#{i}. #{stock.percent_change}% - #{stock.ticker_symbol} - #{stock.name}"
        break if i == 25
      end
    when "volume"
      @stocks.sort{|a,b| b.volume <=> a.volume}.each.with_index(1) do |stock, i|
        puts "#{i}. #{stock.volume}M -Vol   #{stock.ticker_symbol} - #{stock.name}"
        break if i == 25
      end
    when "rating"
      @stocks.sort{|a,b| b.rating <=> a.rating}.each.with_index(1) do |stock, i|
        puts "#{i}. #{stock.rating} -Rating - #{stock.percent_change}- #{stock.ticker_symbol} - #{stock.name}"
        break if i == 25
      end
    when "market_cap"
      @stocks.sort{|a,b| b.market_cap <=> a.market_cap}.each.with_index(1) do |stock, i|
        puts "#{i}. #{stock.market_cap}M  -MktCap- #{stock.ticker_symbol} - #{stock.name}"
        break if i == 25
      end
    end
  end

  def menu
    puts "Enter number of Stock you would like more info on, type 'view options' to view the initial sorting options, 'list' to list stocks, or exit to quit"
    input = gets.strip.downcase
    if input.to_i > 0
      num = input.to_i - 1
      puts""
      puts "#{@stocks[num].name} --- #{@stocks[num].ticker_symbol}"
      puts "-----------------------------------------------------------------"
      puts "Sector  =  #{@stocks[num].sector}"
      puts "Rating  =  #{@stocks[num].rating}"
      puts "Price   =  $#{@stocks[num].price}"
      puts "Prc chg =  #{@stocks[num].change}"
      puts "% chg   =  #{@stocks[num].percent_change}"
      puts "Volume  =  #{@stocks[num].volume}M"
      puts "Mkt Cap =  #{@stocks[num].market_cap}M"
      puts "*** Would you like to open this stock's page for more info?(y/n) ***"
      input_2 = gets.strip.downcase
      if input_2 == "y"
        link = "#{@stocks[num].url}"
        if RbConfig::CONFIG['host_os'] =~ /mswin|mingw|cygwin/
          system "start #{link}"
        elsif RbConfig::CONFIG['host_os'] =~ /darwin/
          system "open #{link}"
        elsif RbConfig::CONFIG['host_os'] =~ /linux|bsd/
          system "xdg-open #{link}"
        end
        menu
      else
        menu
      end
    elsif input == 'view options'
      call
    elsif input == 'list'
      list_stocks
      menu
    elsif input == 'exit'
    else
      menu
    end
  end

  def goodbye
    puts ""
    puts "Thanks for using top-stock-movers!! Have a good day!"
  end
end
