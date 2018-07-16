How to build a CLI gem

1. Plan your gem imagine your interface
2. Start with the project structure - google
3. Start with the entry point - the file run
4. Force that to build the CLI interface
5. stub out the interface
6. start making things real
7. discover objects
8. program

Ideas
  stockmarket biggest movers
  /sport rankings
  dog parks near you
  concerts
  top travel destinations
  cheapest travel destinations from your location
  top rated video games
  k

- A command line interface for biggest stock movers across all exchanges

1. mu
2. vrx

type in number of stock you want to see more about


# to make sure that objects beign added to another are for sure objects and no one can push strings to what you are trying to push objects to
# look into collaborating objects video
class Newsletter
  attr_accessor :articles

  def initialize
    @articles = []
  end

def articles
  @articles.dup.freeze   # this makes it so the only way to add an article is through the add_articles method which then passes it through the article class to make sure - you can't just Newsletter.articles = "string"
end

def add_articles(article)
  raise "invalid article" if !article.is_a?(Article)
end
end
