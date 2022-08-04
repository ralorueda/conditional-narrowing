timeout 36000 maude ./../conditional-narrowing.maude ./bank-account.maude ./tests/standard-1.maude > ./results/standard-1.txt & disown
sleep 2
timeout 36000 maude ./../conditional-narrowing.maude ./bank-account.maude ./tests/standard-2.maude > ./results/standard-2.txt & disown
sleep 2
timeout 36000 maude ./../conditional-narrowing.maude ./bank-account.maude ./tests/canonical-1.maude > ./results/canonical-1.txt & disown
sleep 2
timeout 36000 maude ./../conditional-narrowing.maude ./bank-account.maude ./tests/canonical-2.maude > ./results/canonical-2.txt & disown
sleep 2
timeout 36000 maude ./../canonical-narrowing.maude ./bank-account-transformed.maude ./tests/transformed-1.maude > ./results/transformed-1.txt & disown
sleep 2
timeout 36000 maude ./../canonical-narrowing.maude ./bank-account-transformed.maude ./tests/transformed-2.maude > ./results/transformed-2.txt & disown
sleep 2
timeout 36000 maude ./../conditional-narrowing.maude ./bank-account.maude ./tests/filtered-1.maude > ./results/filtered-1.txt & disown
sleep 2
timeout 36000 maude ./../conditional-narrowing.maude ./bank-account.maude ./tests/filtered-2.maude > ./results/filtered-2.txt & disown