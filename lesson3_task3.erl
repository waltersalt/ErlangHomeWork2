-module(lesson3_task3).
-author("soldatenko").
-export([split/2]).

split(BinText, Delimiter) ->
  split(BinText, Delimiter, byte_size(Delimiter), <<>>, []).

split(<<>>, _, _, <<>>, Acc) ->
  lists:reverse(Acc);
split(<<>>, _, _, Word, Acc) ->
  lists:reverse([Word | Acc]);
split(BinText, Delimiter, DelimSize, Acc, Words) ->
  case binary:match(BinText, Delimiter) of
    {Pos, _} ->
      <<Part:Pos/binary, _/binary>> = BinText,
      split(binary:part(BinText, Pos + DelimSize, byte_size(BinText) - Pos - DelimSize), Delimiter, DelimSize, <<>>, [Part | Words]);
    nomatch ->
      lists:reverse([BinText | Words])
  end.
