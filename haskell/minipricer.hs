module Main
where
import Test.Hspec
import Data.Time
import Data.Time.Calendar.WeekDate

price:: Float -> Float -> Day -> Day -> Float
price initialPrice volatility startDate priceDate
  | startDate == priceDate = initialPrice
  | otherwise =
      price initialPrice volatility nextDate priceDate * (1 + volatility / 100)
      where nextDate = nextOpenDate startDate

nextOpenDate:: Day -> Day
nextOpenDate date
  | weekDay == 5 = addDays 3 date
  | weekDay == 6 = addDays 2 date
  | otherwise = addDays 1 date
  where (_,_,weekDay) = toWeekDate date


d = fromGregorian 2015 05
wednesday  = d 13
thursday   = d 14
friday     = d 15
nextMonday = d 18


main :: IO()
main = hspec $ do

  describe "pricing in future" $ do

    it "should be initialPrice at zero day" $ do
      price 100 10 thursday thursday `shouldBe` 100

    it "should price at one day" $ do
      price 100 10 thursday friday `shouldBe` 110

    it "should price at two days" $ do
      price 100 10 wednesday friday `shouldBe` 121

  describe "pricing over closed days" $ do

    it "should not consider saturday and sunday" $ do
      price 100 10 friday nextMonday `shouldBe` 110

    it "should not consider bank hollidays" $ do
      price 100 10 friday nextMonday `shouldBe` 110

