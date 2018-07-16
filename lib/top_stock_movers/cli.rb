class TopStockMovers::CLI

    ## add method for if they want to open stock page to url
    ## ask first question of how they would like to see their stocks organized - after you complete first part of project
  def call
    list_stocks
    menu
    goodbye
  end

  def list_stocks
    puts "Today's Top Stock Movers"
    TopStockMovers::Stocks.scrape_tradingview
    TopStockMovers::Stocks.all.each.with_index(1) do |stock, i|
      break if i == 26
      puts "#{i}. #{stock.ticker_symbol} - #{stock.percent_change} - #{stock.name}"
    end


  end

  def menu
    puts "Enter number of Stock you would like more info on, type exit to quit"
    input = nil
    while input != "exit"
      input = gets.strip.downcase
      case input
      when "1"
        puts "info on 1"
      when "2"
        puts "info on 2"
      when "list"
        list_stocks
      else
        puts "Invalid input"
      end
    end
  end

  def goodbye
    "Thanks for using top-stock-movers!! Have a good day!"
  end

end
