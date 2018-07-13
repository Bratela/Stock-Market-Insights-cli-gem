class TopStockMovers::CLI

  def call
    puts "Today's Top Stock Movers"
    list_stocks
    menu
    goodbye
  end

  def list_stocks
    puts <<-DOC
    1. stock 1
    2. stock 2
    DOC
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
