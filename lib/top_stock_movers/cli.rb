class TopStockMovers::CLI

    ## add method for if they want to open stock page to url
    ## ask first question of how they would like to see their stocks organized - after you complete first part of project
  def call
    list_stocks
    menu
    goodbye
  end

  def list_stocks
    puts "Today's Top 25 Stock Movers"
    TopStockMovers::Stocks.scrape_tradingview
    @stocks = TopStockMovers::Stocks.all
    @stocks.each.with_index(1) do |stock, i|
      break if i == 26
      puts "#{i}. #{stock.percent_change} - #{stock.ticker_symbol} - #{stock.name}"
    end


  end

  def menu
    puts "Enter number of Stock you would like more info on, type exit to quit"
    input = nil
    while input != "exit"
      input = gets.strip.downcase
      if input.to_i > 0
        num = input.to_i - 1
        stock_info
        open_url
        puts "To review the list again type 'list' or type 'exit' to exit"
      elsif input == 'list'
        list_stocks
      else
        puts "Invalid input"
      end
    end
  end

  def goodbye
    "Thanks for using top-stock-movers!! Have a good day!"
  end

  def stock_info
    puts "Name = #{@stocks[num].name}"
    puts "Ticker Symbol = #{@stocks[num].ticker_symbol}"
    puts "Price = #{@stocks[num].price}"
    puts "Day's price change = +#{@stocks[num].change}"
    puts "Day's % change = +#{@stocks[num].percent_change}"
    puts "Rating = #{@stocks[num].rating}"
    puts "Sector = #{@stocks[num].sector}"
  end

  def open_url
    puts "Would you like to open this stock's page for more info?(y/n)"
    input = gets.strip.downcase
    if input == "y"
      link = "#{@stocks[num].url}"
      if RbConfig::CONFIG['host_os'] =~ /mswin|mingw|cygwin/
        system "start #{link}"
      elsif RbConfig::CONFIG['host_os'] =~ /darwin/
        system "open #{link}"
      elsif RbConfig::CONFIG['host_os'] =~ /linux|bsd/
        system "xdg-open #{link}"
      end
    else
      return
    end
  end


end
