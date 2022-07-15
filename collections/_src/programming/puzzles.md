---
layout: page
title: Puzzles
permalink: /puzzles
---

- TOC
{:toc}

---

# 8 Pennies - find lightest

**Given 8 pennies, 7 weigh exactly same, one weighs less than others. You also have a judge scale. Find the one penny that weighs the least in less than 3 steps.**
 
Step 1 - Split 8 pennies into 3 groups – { 3 , 3 , 2 }.  
Step 2 - Compare groups of 3 pennies.

`Scenario #1`: 
- The 2 groups weigh the same.
- Compare remaining 2 pennies with each other to find the lightest coin.

`Scenario #2`: 
- Unequal group of 3 pennies.
- Pick any 2 pennies out of lighter group.
    - Same weight, remaining penny is lighter.
    - Not same weight, lighter one is the lightest penny.

# Cake Cutting - 8 Pieces with 3 cuts

**Given birthday cake, how to make exactly 3 cuts to make 8 equal pieces ?**

- 2 vertical Cuts in + shape to make 4 pieces
- 1 horizontal cut to make it 8 pieces.

# Find Number between 1 and 1000

**Given the numbers 1 to 1000, what is the minimum number of guesses needed to find a specific number if you are given the hint ‘higher’ or ‘lower’ for each guess you make?**

- Someone can guess the right question on their first try right. So, the answer here would be ‘1’.
- maximum number of guesses is 999.
- Using Binary Search to find a number from 1 to 1,000 – 10 (500, 250, 125, 63, 32, 16, 8, 4, 2, 1)


# 3 Switches 3 Bulbs

**Suppose that you are standing in a hallway next to 3 light switches, which are all off. There is another room down the hallway, where there are 3 incandescent light bulbs – each light bulb is operated by one of the switches in the hallway. Because the light bulbs are in another room, you can not see them since you are standing in the hallway.**

**How would you figure out which switch operates which light bulb, if you can only go the room with the light bulbs one time, and only one time?**

Well, the properties of a switch don’t seem to have anything unique to them – they are just either simply on or off. What about the light bulbs? Well, we do know that incandescent light bulbs get hot when they are on – this sounds like it might just lead to something useful that can help us. We know that the longer an incandescent light bulb stays on the hotter it gets.

So, if we turn one switch off after 5 minutes, turn the second one on, and leave the last one off then what happens? Well, the light bulb corresponding to the first switch will still be warm (even though it’s off), the bulb corresponding to the second switch will be on, and the bulb corresponding to the last switch will be off. This is enough information so that we can go into the attic only once and figure out which switch belongs to which light bulb.

# Measure 4L via 5L and 3L Jugs

**Suppose you have a 3 liter jug and a 5 liter jug. The jugs have no measurement lines on them either. How could you measure exactly 4 liter using only those jugs and as much extra water as you need?**

`Step 1` : First, fill the 5 liter jug and then pour it into the 3 liter jug. The 5 liter jug now has only 2 liters left.

`Step 2` : Next, empty out the 3 liter jug. Then, pour the 2 liters from the 5 liter jug to the 3 liter jug. So, now the 3 liter jug has 2 liters.

`Step 3` : Fill the 5 liter jug again, and pour 1 liter into the 3 liter jug. Now, what’s left in the 5 liter jug? Well, exactly 4 liters! There’s your answer.

# 25 Horses Race

**You have to pick the fastest 3 horses out of those 25, you can race 5 horses at a time. What is minimum number of races required without using stopwatch.**

In each row, the fastest horses are listed in descending order, from the fastest (extreme left) to the slowest (extreme right). The fastest horses in each race are the ones on the left – so in the first race X1 was the fastest and X5 was the slowest. In the second race X6 was the fastest, X7 was the second fastest and so on.

`Step1` : 5 races – Winners (X1, X6, X11, X16, and X21). These are all the fastest horses in their individual groups, but there could be one group that just happened to have all of the fastest horses. 

`Step2` : Need Top 3 hence remove 4th and 5th from all 5 races.

`Step3`: 6th Race - (X1, X6, X11, X16, and X21). Remove rows for X16 and X21.

`Step4` : 7th Race – (X2,X3,X6,X7,X11) to find 2nd and 3rd fastest. Possible - [(1,2,3) , (1,6,11) , (1,6,7)]

# Weigh an Elephant without scale

**How would you weigh an elephant without using a scale?**

If we are not allowed to use a weighing machine then what are our options? Well, there aren’t very many.
It helps to think of natural things of which we already know the properties of. Let’s think of water – that’s something natural that has a lot of measurable properties. Well, we do know that one of the properties of water is that it weighs 1 kg. per liter, or 8.34 lbs per gallon. What if we put the elephant on a big raft inside a full tank of water? What we could do then is measure the volume of water that’s displaced from the tank and that would give us a great approximation of the weight of the elephant.

# 100 Lockers

**You are standing in a school hallway lined with 100 closed lockers. You then open all 100 lockers. After this, you then close every 2nd locker (so the 2nd, 4th, 6th…98th and 100th are all closed). Then, you go to every third locker and open it if it is closed or close it if it is open (let’s call this toggling the locker for our discussion). You proceed to toggle every nth locker on pass number n. So, for example, on pass number 16 – you will toggle every 16th locker. After your hundredth pass of the hallway, in which you toggle only locker number 100, how many lockers are now open?
In a hall with x lockers, how many lockers remain open after pass number x?**

Let’s choose locker # 6.

Pass # 1: all lockers are opened, including locker # 6  
Pass # 2: all even numbered lockers are closed, including locker # 6  
Pass # 3: every 3rd locker is toggled…so 3, 6, 9, ….96, 99. includes locker # 6.  
Pass # 4: 4, 8, 12, etc. are all toggled. Excludes #6.  
Pass # 5: 5, 10, 15 are all toggled. Excludes # 6 again.  
Pass # 6: 6, 12, 18, etc. are all toggled. Includes # 6.  

Locker #6 is only toggled when the number of the pass (also called “x”) that you are on is a factor of the # 6 –1,2, 3, and 6 are all factors of 6. And those are all the passes on which the locker 6 is toggled – the sequence is open, close, open and then close. So, locker # 6 ends up closed.

A prime number only has 2 factors – itself and ‘1’. Operations are open and then close for any pass greater or equal to 13. So, it ends up being closed.

If a locker is toggled an even number of times it ends up closed, otherwise it ends up open. We can say that a locker will end up closed if it has an even number of factors, because the number of times a locker is toggled equals the number of factors. If a locker has an odd # of factors, the locker will end up being open.

What exactly does it mean when we say that c is a factor of d, for some #’s c and d?
Well, it means that c multiplied by some other number b is equal to d. This also means that b is also a factor of d since multiplication is commutative (c*b = b*c). So, the number of factors is usually even since factors tend to come in pairs. And an even number of factors means that the locker will end up being closed.

For Perfect square, we would have an odd number of factors – and an odd number of factors would mean that particular locker will remain open. Since there aren’t very many perfect squares between 1 and 100, you can list them out – here they are: 1, 4, 9, 16, 25, 36, 49, 64, 81 and 100 – so, exactly 10 lockers will remain open.

### Generalizing the solution to this brain teaser
If there are x lockers, the number of open lockers will be the number of perfect squares between 1 and x (inclusive). To count them, all you need to do is find the square root of the largest perfect square less than or equal to x. So, the general solution would be: **floor(sqrt(x))**

If x = 200, then sqrt(200) = 14.142 And because floor(sqrt(200)) = 14, there will be 14 open lockers.

# Rope Bridge 4 People 1 Flashlight

**Four people need to cross a rickety rope bridge to get back to their camp at night. Unfortunately, they only have one flashlight and it only has enough light left for seventeen minutes. The bridge is too dangerous to cross without a flashlight, and it’s only strong enough to support two people at any given time.

Each of the campers walks at a different speed. One can cross the bridge in 1 minute, another in 2 minutes, the third in 5 minutes, and the slowest camper takes 10 minutes to cross. How can the campers make it across in exactly 17 minutes?**

Let’s start out trying to solve this problem by re-stating some of the facts that we have: only 2 travelers can cross the bridge at a time, there is only one flashlight, each traveler has a different speed, and our goal is to have all travelers cross the bridge in exactly 17 minutes. It always helps to restate the relevant facts so that we can narrow down the parameters of the problem.

So, it’s clear that there will need to be someone who brings back the flashlight every time. This means that it makes the most sense to have 2 people cross the bridge at a time, but only have one person bring back the flashlight. And, why not just have the fastest person bring back the flashlight every time – the 1 minute person? 

```
5,10 --- 1,2 > --- 
5,10 --- < 1 --- 2
10 --- 1,5 > --- 2
10 --- < 1 --- 2,5
 --- 1,10 > --- 2,5

// 19 Minutes
```
```
5,10 --- 1,2 > --- 
5,10 --- < 1 --- 2
1 --- 10,5 > --- 2
1 --- < 2 --- 10,5
 --- 1,2 > --- 10,5

// 17 Mnutes
```
Anyone who crosses the bridge with 10 will have to take 10 minutes. Lets have 10 go with the second slowest camper.

# 8 Marbles Find Heaviest

**Suppose you have 8 marbles and a two-pan balance used to compare the weight of 2 things. All of the marbles weigh the same except for one, which is heavier than all of the others. How would you find the heaviest marble if you are only allowed to weigh the marbles 2 times?**

We put 3 marbles on each pan – for a total of 6 marbles on the pan, and we leave 2 marbles off the pan. Then, we compare the 6 marbles on the pan – if one side is heavier than the other then we only have 3 marbles left. We can compare 2 of those 3 marbles to each other, and if they are the same weight then the 3rd is the heaviest, and if one is heavier than the other then we have the heaviest in just 2 weighings. If, when comparing the 6 marbles we find that both sides are equal, then we know that the heaviest marble has to be in the 2 marbles that are not on the pan. This then means that we only have to compare those 2 remaining marbles and we have the heaviest marble.

## 8 Marbles Find Heaviest - Generic

**How would you generalize the solution to find the minimum number of weighings if you are given n marbles?**

What’s the best way to start generalizing our solution so that it works even for n marbles? Well, let’s try to break down the solution we found when we had exactly 8 marbles – and we only had to do 2 weghings to find the heaviest marble. What exactly happened after each weighing? Well, after each weighing we were able to eliminate 2/3 of the marbles, but we kept 1/3 of the marbles for the next weighing.

Is there a way we can take this information and generalize it into a solution for n marbles? What if we started out with 9 marbles? Well, we could find the heaviest marble with just 2 weighings as well – because in the first weighing we could eliminate 2/3 or 6 of the marbles, and in the second weighing we could eliminate 2/3 of the remaining 3 marbles – or 2 marbles, which would leave us with just the heaviest marble. It sounds like with every weighing we would be left with 1/3 of the marbles, and once we get to just one marble, then we are done since we have found the heaviest marble.

### Come up with an equation
Another way of saying this is that, if x is the number of weighings and n is the number of marbles, then 3x would equal n. This is true in the scenario where we have 9 marbles, because 32 is equal to 9 – so it takes 2 weighings to find the heavy marble out of 9 marbles. So, if x is the minimum number of weighings to find the heavy marble, then this would mean that x = log3n.
What if we just had 8 marbles – would that equation (x = log3n) still apply? Actually, it would not because of the fact that the the log38 is equal to 1.893 – and we can not have 1.893 weighings – we can only have whole numbers. So, what needs to be done here? Well, we would need to round up to 2. But, the real question is whether rounding up would be valid for all other number of marbles.

### Does rounding up always work?
Let’s see if rounding up works for 10 marbles. log310 would give us a little more than 2 – so if we round up to 3 would that be valid? In other words, in only 3 weighings can we find the heavy marble out of 10 marbles? Let’s break it down – we would start out with 2 groups of 3 (which we put on the scale) and one group of 4. Then, after one weighing we would be left with either 3 marbles or 4 marbles, depending on which group the heavy marble is in. If it’s in the group of 3 marbles we would need one more weighing to find the heavy marble, for a total of 2 weighings. However, if the heavy marble is in the group of 4, then we would need 2 more weighings for a total of 3 weighings. So, the answer varies depending on where the marble is. But, the question asks us to find the minimum number of weighings in which we are **guaranteed** to find the heavy marble, and that would be 3 weighings in this case.

So, we would have to round up in every case we have a fractional number in order to find the heaviest marble, and another way of saying that is we want to find the **ceiling** of lognb3. And that is the correct answer – given n marbles, it takes ceiling (lognb3) weighings to find the heavy marble.

How much easier it would have been to solve the previous problem if the number of marbles was 9, because you are able to split the marbles into 3 groups of 3. But, with 8 marbles, the problem becomes more difficult and forces you to think a bit more. So, it’s always good to remember to try out different scenarios, and not to be misled into thinking about the problem in the wrong way because of a small detail in the problem.

# Hat Puzzle – Black and White Hat

**Suppose there are 4 prisoners named W, X, Y, and Z. Prisoner W is standing on one side of a wall, and prisoners X Y and Z are standing on the other side of the wall. Prisoners X, Y, and Z are all standing in a straight line facing right – so X can see prisoner Y and Z, and Y can see prisoner Z. This is what their arrangement looks like, Where the `“||”` represents a wall. The wall has no mirrors. So, prisoner W can see the wall and nothing else.**

`W || X Y Z `

**There are 2 white hats and 2 black hats and each prisoner has a hat on his head. Each prisoner can not see the color of his own hat, and can not remove the hat from his own head. But the prisoners do know that there are 2 white hats and 2 black hats amongst themselves. The prison guard says that if one of the prisoners can correctly guess the color of his hat then the prisoners will be set free and released. The puzzle for you is to figure out which prisoner would know the color of his own hat?**

**Note that the prisoners are not allowed to signal to each other, nor speak to each other to give each other hints. But, they can all hear each other if one of them tries to answer the question. Also, you can assume that every prisoner thinks logically and knows that the other prisoners think logically as well.**

Clearly prisoners W and Z can not immediately know anything since neither of those prisoners can see any of the other prisoners. So, let’s instead focus on prisoners X and Y.

```
W       || X        Y       Z
Black   || Black White White 
```
```
W       || X        Y       Z
Black   || White Black White 
```
In the scenario above, prisoner X will clearly see that Y and Z both have white hats, and logically deduce that he must have a black hat since there are 2 white hats and 2 black hats all together – and he would be correct. 

In the example above, prisoner X will see that Y and Z have black and white hats. This means that prisoner X will reason that he can not conclusively say whether or not he has a white hat or a black hat – because he knows that that there are 2 black hats and 2 white hats and he sees 1 black and 1 white, so he himself could be wearing either a white or a black hat.

### If 5 minutes pass and none of the prisoner say anything…

But, if prisoner X does not say anything for some time (it doesn’t really matter how long much time has passed), then prisoner Y will know that prisoner X does not know the color of his own hat. The silence of prisoner X means that prisoner Y will know that prisoner X must be seeing both a white hat and a black hat – and one of those hats is the one that prisoner X is wearing. And if prisoner Y can see that prisoner Z is wearing a white hat, then prisoner Y knows that he himself must be wearing a black hat. So, prisoner Y will speak out and all of the prisoners will be released again!

# 2 Eggs 100 Floors

**Suppose that there is a building with 100 floors. You are given 2 identical eggs. The most interesting property of the eggs is that every egg has it’s own “threshold” floor. Let’s call that floor N. What this means is that the egg will not break when dropped from any floor below floor N, but the egg will definitely break from any floor above floor N, including floor N itself.**

**For example, if the property of the eggs is that N equals 15, those eggs will always break on any floor higher than or equal to the 15th floor, but those eggs will never break on any floor below floor 15. The same holds true for the other egg since they are identical.**

**These are very strong eggs, because they can be dropped multiple times without breaking as long as they are dropped from floors below their “threshold” floor, floor N. But once an egg is dropped from a floor above it’s threshold floor**

**Here is the puzzle: What strategy should be taken in order to minimize the number of egg drops used to find floor N (the threshold floor) for the egg? Also, what is the minimum number of drops for the worst case using this strategy?**

**Remember that you are given 2 identical eggs which both have the same exact threshold floor.**

Binary search method - Let’s say we do start at the 50th floor and the egg breaks. Then we go to 25th and second egg also breaks. Then we really don’t have an answer to the problem since we have not found the threshold floor for the eggs. Clearly the binary search method does not work for us here, because we only have 2 eggs. The binary search method would be good in a scenario where we have an infinite number of eggs, but we now have to change our strategy and find a better solution.

Sequencial will 10 floor gap – 10, 20, 30, 40…..100. Here in worst case, 19 drops required.

### SOLUTION

The main reason why it takes such a large number of drops in the worst case with our approach above (19 drops) is because in order to test out the higher floors of the building we have to start at the lower floors of the building, and at that point we have already used a large number of drops just to get to that point. What we should try to get with our next approach is to try to reduce the worst case scenario by **trying** to make all possible scenarios take the same number of drops.

What if we tried to reduce the number of drops that would be required with the linear search (with the 2nd egg) after we get to one of the higher floors? This way we counteract the fact that getting to the higher floor took so many drops, and if we use less drops for the linear search we are balancing out the worst case.

Suppose we drop an egg from floor x. If the egg breaks, then we would have to go through the previous x-1 floors one by one using a linear search.

But, if the egg doesn’t break, in our original algorithm we would go up x floors to find the next floor to test from. Why not just go up x-1 floors instead of x floors? This would save us 1 drop if we have to do a linear search with the 2nd egg whenever the first egg breaks – because we would be doing the linear search from floors x+1 to floor ( (x+1) + (x-1)) instead of floors x+1 to floor (x+1) + x. So, that is 1 less egg drop. This means that the next floor that should be attempted to drop from is x + (x-1) if the egg does not break from floor x. And by the same reasoning the floor after that would be x + (x-1) + (x-2) if the egg does not break on floor x + (x-1).
```
x + (x-1) + (x-2) + (x-3) + ... + 1
```
The series above is what’s called a triangular series which is equal to x(x+1)/2. Because there are 100 floors in the building, we set the sum equal to 100 to solve for x: **x(x+1)/2 = 100**

x = 13.651, which rounds up to 14. This means that we should start from floor 14 (which is our x) and then move up x-1 (13) floors to floor 27 if the egg doesn’t break and then move up x-2 (12) floors to floor 39 and so on if the egg still does not break.
```
14 – 27 – 39 – 50 – 60 – 69 – 77 – 84 – 90 – 95 – 99 - 100
```
**Worst case** - when the threshold floor is floor number 14 – because we will drop the first egg on floor 14, and it will break. Then we have to test floors 1-13 with the 2nd egg to see where the egg breaks again, and the egg will not break on any of those floors. But since the egg broke on the floor 14, we can conclude that the threshold floor is floor number 14.

# Squares on Chess Board

**How would you find the number of squares on a chessboard?**

Clearly there are 64 of the little squares on a chessboard (as you can see below), but this question is meant to ask you for more than just the number of the small squares since that would be too easy. There are other squares on the chessboard – note that if we combine 4 of the small squares on the board together then they form a 2×2 square, and we can even combine 16 of the small squares together to form a 4×4 square.

```
Square Size	= Total Squres
1×1	= 64
2×2	= 49
3×3	= 36
4×4	= 25
5×5	= 16
6×6	= 9
7×7	= 4
8×8	= 1
TOTAL=204
```

### Number of squares for an NxN chessboard?

For the normal-sized 8×8 chessboard, you can see that the number of squares is equal to the sum of squares from 12 to 82, where 8 is equal to N. So, we can say in more general terms that the sum of squares for a chessboard of size NxN is equal to 
```
n2 + (n-1)2 + (n-2)2 + …. (1)2  = n(n + 1)(2n + 1)/6
```

# 3 Ants Triangle

**Suppose that you have a triangle with 3 ants on different vertices (corners) of the triangle. What is the probability that either 2 of the ants or all of the ants collide if all 3 ants start walking on the sides of the triangle?**

Whether or not the ants collide depends on what direction the ants are walking in.

Let’s start by reversing the way the riddle is asked and find the probability that there will **not** be a collision instead. When will this happen?

Walking in the same direction then there will never be a collision – 2 cases (counter-clockwise or clockwise) Total Cases - 23 (which equals eight) possible ways that the ants can move. 

There are 6 scenarios where the ants will collide. And 6 out of 8 possible scenarios, means that the probability of collision is 6/8, which equals 3/4 or .75. Thus, the probability of the ants colliding is .75.

# 2 Fuses Measure 45 Minutes

**You have 2 fuses and a lighter. When each fuse is lit, it takes exactly one hour to burn from one end to the other. You can assume that both of the fuses are identical. Using only those 2 fuses and the lighter, how would you measure a period of exactly 45 minutes?**

What if we start the flame from the middle of a fuse? Would that allow us to measure half an hour? Actually, no it would not, because we can not assume that half of the **length** of the fuse would burn in half an hour – it may just be that 1/10th of the length of the fuse take 50 minutes to burn and the other 9/10ths of the fuse takes 10 minutes to burn. So, starting the flame in the middle of the fuse is not a valid option.

What would happen if we burn a fuse from both sides? That sounds interesting. Well, what would happen is that the fuse would burn out in just 30 minutes – this is because the fuse would be burning from both sides and the flames would burn until they meet each other and extinguish after exactly 30 minutes. Well, that sounds very useful – because we can now measure 30 minutes!

We are assuming that the burn rate is uniform – meaning that burning 1/4th of the fuse from one end will take exactly the same amount of time as burning 1/4th of the fuse from the other end of the fuse. It could potentially take 1 minute to burn the first 9/10th of the rope and 59 minutes to burn just the last 1/10th of the rope if the burn rate were not uniform. This was not an assumption stated in the problem, but it is important, and if you ever do encounter this question in an interview it is an assumption you should probably make whether the interviewer states it or not (some interviewers are bad enough to just ask this question without really understanding) because there really would be no solution to this problem if we did not assume the burn rate was uniform. 

Now that we can measure 30 minutes, how could we measure 15 minutes more to get 45 minutes total? Well, can we use the idea of burning a fuse from both sides to measure that extra 15 minutes? That sounds like it has potential – what if we burn fuse # 1 from both ends, and we burn fuse #2 from only one end. Then, after 30 minutes has passed, we can burn the other end of fuse #2. Fuse #2 would finish burning in 15 minutes because it has already has 30 minutes worth of time burned from it, but it is also burning from both ends – so that cuts the burning time in half. And 30 + 15 would give us 45 minutes – so we finally have an answer!

# Train Escapes 2 Boys

**Suppose 2 boys are walking in the woods and they decide to take a shortcut through a railroad tunnel. They had walked 2/3 of the way through the tunnel, but then something horrible happened: a train was coming in the opposite direction towards the 2 boys, and it was coming close to the other entrance of the tunnel. Each boy ran in a different direction to get out of the tunnel and avoid the incoming train. Each boy ran at the same exact speed of 10 miles per hour, and each boy managed to escape the train at the exact instant in which the train would have hit and killed him. If the train was moving at a constant speed and each boy was capable of instantaneous acceleration, then how fast was the train going?**

```
<--- 2/3--->|<-1/3->|   
        <- B A ->               <----TRAIN
----------------------------
```

So, what other information is important here? The fact that the boys barely escape. Each boy would have been hit by the train at a different time - since they were running in different directions.

A had to pass 1/3 of the tunnel to get out, and because B runs at the same exact rate as A, it must mean that B has also passed another 1/3 of the tunnel by the time the train is right outside the other end of the tunnel. And because B started out 2/3 of the way into the tunnel, this means that B has to pass another 2/3 - 1/3, which equals 1/3 of the tunnel in order to get out.
```
<--1/3-->-------------  
         <- B                 <-TRAIN
------------------------- A
```
Remember that B will get out of the tunnel at the exact moment when the train was about to hit him. This means that the train will travel the entire length of the tunnel, and B will travel just 1/3 of the tunnel - ***but they both get to the end of the tunnel at the same time.*** This also means that the train must travel 3 times as fast as B (since B only travels 1/3 of the tunnel to reach the end, but the train travels the entire length of the tunnel to reach the end, but they both reach the end at the same exact time). And, since B travels at a speed of 10 miles per hour, the train moves at 30 miles per hour (3 * 10). So, we have our answer!

# Same National Champion 65 Year Span

**There’s an activity in America, with one-on-one contests, and a national championship. The same person won the championship on two different occasions about 65 years apart. Name the activity.**

This was a question that Charlie Munger (a partner of Warren Buffet’s) asked a group of students in a speech he gave. 

### Breaking the problem down
Let’s figure this out. Well, since the championship was won by the same person over a span of 65 years, that means the second time around this person must have won the championship when he was at least 85 years old, and that’s assuming that he first won the championship when he was at least 20 years old.

This also means that there’s no way that this activity requires any hand eye coordination – because anyone over 85 years old will simply not be able to beat someone in his 20’s. So, there’s no way this was a billiards tournament, and definitely not a tennis tournament.

What about a chess tournament? Well, even though it is a mental game, it does require quite a bit of stamina – and is far too competitive for an 85 year old to be competitive at a national level, even if he can beat a lot of other younger people. If not chess, then what about checkers? Well, that sounds like a potential answer! Because, that is definitely a game where experience can make you the best even though you may be 85 years old. And it’s also a game which does not require much stamina, or any athleticism at all. And that is the correct answer – it is a checker’s tournament.

The name of this person, in case you were wondering is Asa A. Long (born on 20 Aug 1904). He became the youngest US national champion, at 18 years old 64 days, when he won in Boston, Massachusetts, USA on 23 Oct 1922. He then became the oldest person to win the national checkers tournament in America, at age 79 years 334 days when he won his sixth title in Tupelo, Mississippi, USA on 21 Jul 1984.

