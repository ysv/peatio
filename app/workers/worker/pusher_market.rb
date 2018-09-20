# encoding: UTF-8
# frozen_string_literal: true

require "peatio/mq/events"

module Worker
  class PusherMarket
    def process(payload)
      trade = Trade.new(payload)

      Peatio::MQ::Events.publish("private", trade.ask.member.sn, "trade", trade.for_notify("ask"))
      Peatio::MQ::Events.publish("private", trade.bid.member.sn, "trade", trade.for_notify("bid"))
      Peatio::MQ::Events.publish("public", trade.market.id, "trades", {trades: [trade.for_global]})
    end
  end
end


def process(payload)
  trade = Trade.new(payload)
  Pusher["private-#{trade.ask.member.sn}"].trigger(:trade, trade.for_notify('ask'))
  Pusher["private-#{trade.bid.member.sn}"].trigger(:trade, trade.for_notify('bid'))
  Pusher["market-#{trade.market.id}-global"].trigger(:trades, trades: [trade.for_global])
end