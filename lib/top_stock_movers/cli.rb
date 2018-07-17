class TopStockMovers::CLI

    ## add method for if they want to open stock page to url
    ## ask first question of how they would like to see their stocks organized - after you complete first part of project
  def call
    list_viewing_options
    list_stocks
    menu
    goodbye
  end

  @@viewing_options = {"Gainers" => "Stocks that have increased the most in price", "Losers" => "Stocks that have lost most of their value", "Most-Active" => "Stocks that have been traded the most", "Most-Volatile" =>"The volatility of a stock is the fluctuation of price in any given timeframe", "Overbought" => "Stocks that have significantly increased in price due a large demand are called overbought", "Oversold" => "As opposed to overbought, oversold means that stock prices have decreased substantially.", "Large-Cap" => "Largest companies by market cap"}
  @@selection = nil

  def list_viewing_options
    puts "How would you like to view today's Top Market Movers? please enter corresponding number."
    @@viewing_options.each_pair.with_index(1) do |view, i|
      puts "#{i}. #{view[0]} -- #{view[1]}"
    end
    input = gets.strip.to_i - 1
    @@selection = @@viewing_options.keys[input]
  end

  def list_stocks
    puts "Today's Top 20 Stock #{{@@selection}} stocks"
    TopStockMovers::Stocks.scrape_tradingview(@@selection.to_s)
    @stocks = TopStockMovers::Stocks.all
    @stocks.each.with_index(1) do |stock, i|
      break if i == 21
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
