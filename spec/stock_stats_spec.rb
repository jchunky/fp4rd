require 'active_support/all'
require_relative '../lib/stock_stats.rb'

describe StockStats do
  it 'matches regression test' do
    expected = <<-STR.strip_heredoc
        Time to sum!
        Counting books
        Counting errors
      Total price on 5 books: 207.19
      4 lines were rejected
      Errors
      Amount not defined on row {"Date"=>"2008-04-12", "ISBN"=>"978-1-9343561-0-4", "Crunchy bits"=>"39.45"}
      Amount not defined on row {"Date"=>"2008-04-13", "ISBN"=>"45.67", "Crunchy bits"=>:no_value_given}
      Amount not defined on row {"Date"=>"2008-04-14", "ISBN"=>"978-1-9343560-7-4", "Crunchy bits"=>:no_value_given}
      No price on book
    STR

    output = capture do
      StockStats.run(['crap_data.csv', 'data.csv', 'mixed_data.csv'])
    end

    expect(output).to eq(expected)
  end

  def capture(&block)
    old_stdout = $stdout
    $stdout = StringIO.new
    block.call
    $stdout.string
  ensure
    $stdout = old_stdout
  end
end
