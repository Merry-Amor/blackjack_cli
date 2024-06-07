def makeCardList
  cardList = []
  13.times do |i|
    if i != 0 then
      cardList.push(i)
    end
  end
  return cardList
end

class DealerController

  def initialize
    @alreadyStand = false
  end

  def command cardList
    if cardList.sum < 17
      return "Hit"
    else
      return "Stand"
    end
  end

  def isStand?
    return @alreadyStand
  end

  def stand
    @alreadyStand = true
  end

end

class Show

  def wait
    sleep(1)
  end

  def cardList playerCardList, dealerCardList
    puts "ディーラーのカード : #{dealerCardList}"
    wait()
    puts "あなたのカード : #{playerCardList} : 合計(#{playerCardList.sum})"
    wait()
  end

  def allCardList playerCardList, dealerCardList
    puts "ディーラーのカード : #{dealerCardList} : 合計(#{dealerCardList.sum})"
    puts "あなたのカード : #{playerCardList} : 合計(#{playerCardList.sum})"
    wait()
  end

  def command
    puts "1）ＨＩＴ：もう１枚カードを引く"
    puts "2）ＳＴＡＮＤ：現在のカードで勝負する"
    wait()
    printf ">"
  end

  def playerHit
    puts "あなた「ＨＩＴ」"
    wait()
  end

  def playerStand
    puts "あなた「ＳＴＡＮＤ」"
    wait()
  end

  def noCommandError
    puts "1か2を入力してください"
    wait()
  end

  def playerNewCard card
    puts "あなたは#{card}を引いた"
    wait()
  end

  def dealerHit
    puts "ディーラー「ＨＩＴ」"
    wait()
  end

  def dealerStand
    puts "ディーラー「ＳＴＡＮＤ」"
    wait()
  end

  def dealerNewCard card
    puts "ディーラーは#{card}を引いた"
    wait()
  end

  def alreadyStand
    puts "ディーラー「既にＳＴＡＮＤしています」"
    wait()
  end

  def playerBust
    puts "あなたはＢＵＳＴしました。あなたの負けです"
    wait()
  end

  def dealerBust
    puts "ディーラーはＢＵＳＴしました。あなたの勝ちです"
    wait()
  end

  def playerWin
    puts "あなたの勝ちです"
    wait()
  end

  def playerLose
    puts "あなたの負けです"
    wait()
  end

end

show = Show.new
dealer = DealerController.new
gameStatus = 'play'
cardList = []
cardList = makeCardList()
playerCardList = []
dealerCardList = []
2.times do
  playerCardList.push(cardList.sample)
end
2.times do
  dealerCardList.push(cardList.sample)
end
loop do
  show.cardList(playerCardList,dealerCardList)
  if playerCardList.sum > 21
    show.playerBust()
    gameStatus = 'lose'
    break
  end
  show.command()
  command = gets.chomp!.to_i
  case command
  when 1
    show.playerHit()
    newCard = cardList.sample
    show.playerNewCard(newCard)
    playerCardList.push(newCard)
    if dealer.isStand?() then
      show.alreadyStand()
    else
      case dealer.command(dealerCardList)
      when "Hit"
        show.dealerHit()
        newCard = cardList.sample
        show.dealerNewCard(newCard)
        dealerCardList.push(newCard)
      when "Stand"
        show.dealerStand()
        dealer.stand()
      else
        abort("No Command Error")
      end
    end
  when 2
    show.playerStand()
    break
  else
    show.noCommandError()
  end
end
if gameStatus != 'lose' then
  show.allCardList(playerCardList,dealerCardList)
  if dealerCardList.sum > 21
    show.dealerBust()
  else
    if playerCardList.sum > dealerCardList.sum then
      show.playerWin()
    else
      show.playerLose()
    end
  end
end