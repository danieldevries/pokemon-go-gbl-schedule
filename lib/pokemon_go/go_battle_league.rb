module PokemonGo
  class GoBattleLeague
    def self.uri
      URI.parse 'https://pokemongolive.com/en/post/gobattleleague-seasonoflight/'
    end

    def self.schedule
      body = Net::HTTP.get(uri)

      document = Nokogiri::HTML(body)

      collection = []

      document.css('.GBLScheduleBlock .GBLScheduleBlock__schedule__item').map do |schedule_item|
        leagues = schedule_item.css('.GBLScheduleBlock__schedule__item__content .GBLScheduleBlock__schedule__item__league').map do |league|
          {
            name: league.css('.GBLScheduleBlock__schedule__item__league__name')[0].text.strip,
            image_url: league.css('.GBLScheduleBlock__schedule__item__league__icon img')[0]['src']
          }
        end

        collection.push({
          start_date: schedule_item['data-start-date'],
          start_timestamp: schedule_item['data-start-timestamp'],
          end_date: schedule_item['data-end-date'],
          end_timestamp: schedule_item['data-end-timestamp'],
          note: schedule_item.css('.GBLScheduleBlock__schedule__item__footer')[0]&.text&.strip,
          leagues: leagues
        })
      end

      collection
    end
  end
end
