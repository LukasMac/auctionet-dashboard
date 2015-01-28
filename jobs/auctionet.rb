require 'auctionet-stats'

stats = Auctionet::Stats.new
recent_bid_amount = 0
SCHEDULER.every '10s' do

  current_bid_amount = stats.item_with_recent_bid.recent_bid_amount
  items = stats.take_items(5).map do |item|
    { label: item.title, value: item.recent_bid_amount }
  end

  send_event('items-recent-bid', { items: items } )
  send_event('sek-over-eur-domination', { value: stats.sek_over_eur_domination })
  send_event('recent-bid', { current: current_bid_amount, last: recent_bid_amount })
  recent_bid_amount = current_bid_amount
end


