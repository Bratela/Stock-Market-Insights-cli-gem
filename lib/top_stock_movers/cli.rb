class TopStockMovers::CLI

    ## add method for if they want to open stock page to url
    ## ask first question of how they would like to see their stocks organized - after you complete first part of project
  def call
    list_viewing_options
    list_stocks
    menu
    goodbye
  end

  class Viewing_options
    attr_accessor :name, :desc, :sorter

    @@all = []

    def self.all
      @@all
    end

    @@viewing_options = [["Gainers", "Stocks that have increased the most in price", "percent_change"], ["Losers", "Stocks that have lost most of their value", "percent_change"], ["Active" , "Stocks that have been traded the most", "volume"],  ["Most-Volatile", "The volatility of a stock is the fluctuation of price in sany given timeframe", "percent_change"],  ["Overbought", "Stocks that have significantly increased in price due a large demand", "rating"], ["Oversold", "stock prices have decreased substantially", "rating"], ["Large-Cap", "Largest companies by market cap", "market_cap"]]

    @@viewing_options.each do |array|
      option = self.new
        option.name = array[0]
        option.desc = array[1]
        option.sorter = array[2]
        @@all << option
    end
  end


  @@selection = nil

  def list_viewing_options
    puts "How would you like to view today's Top Market Movers? please enter corresponding number."
    puts ""
    Viewing_options.all.each.with_index(1) do |option, i|
      puts "#{i}. #{option.name} -- #{option.desc}"
    end
    input = gets.strip.to_i - 1
    @@selection = Viewing_options.all[input]
  end

  def list_stocks
    puts "Today's Top #{@@selection.name} stocks"
    TopStockMovers::Stocks.scrape_tradingview(@@selection.name.downcase)
    sorter = @@selection.sorter
    binding.pry
    @stocks = TopStockMovers::Stocks.all.sort{|stock| stock.sorter}
    @stocks.each.with_index(1) do |stock, i|
      puts "#{i}. +#{stock.percent_change} - #{stock.ticker_symbol} - #{stock.name}"
    end
  end

  def menu
    puts "Enter number of Stock you would like more info on, type 'list' to list stocks, type exit to quit"
    input = gets.strip.downcase
    if input.to_i > 0
      num = input.to_i - 1
      puts "Name = #{@stocks[num].name} --- #{@stocks[num].ticker_symbol}"
      puts "Sector = #{@stocks[num].sector}"
      puts "Rating = #{@stocks[num].rating}"
      puts "Price = #{@stocks[num].price}"
      puts "Day's price change = +#{@stocks[num].change}"
      puts "Day's % change = +#{@stocks[num].percent_change}"
      puts "Volume = #{@stocks.volume}"
      puts "Market Cap = #{@stocks.market_cap}"
      puts "Would you like to open this stock's page for more info?(y/n)"
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
      else
        menu
      end
    elsif input == 'list'
      list_stocks
      menu
    elsif input == 'exit'
    else
      menu
    end
  end

  def goodbye
    puts "Thanks for using top-stock-movers!! Have a good day!"
  end
end
