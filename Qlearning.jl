### A Pluto.jl notebook ###
# v0.17.4

using Markdown
using InteractiveUtils

# ╔═╡ 74b76ae0-7a07-11ec-2856-f1315c1e4b59
html"""
	<div>Happy holiday! Remember to take care of yourself and your loved ones!</div>
<div id="snow"></div>
<style>
	body:not(.disable_ui):not(.more-specificity) {
        background-color:#e9ecff;
    }
	pluto-output{
		border-radius: 0px 8px 0px 0px;
        background-color:#e9ecff;
	}
	#snow {
        position: fixed;
    	top: 0;
    	left: 0;
    	right: 0;
    	bottom: 0;
    	pointer-events: none;
    	z-index: 1000;
	}
</style>
<script src="https://cdn.jsdelivr.net/particles.js/2.0.0/particles.min.js"></script>
<script>
        setTimeout(() => window.particlesJS("snow", {
            "particles": {
                "number": {
                    "value": 70,
                    "density": {
                        "enable": true,
                        "value_area": 800
                    }
                },
                "color": {
                    "value": "#ffffff"
                },
                "opacity": {
                    "value": 0.7,
                    "random": false,
                    "anim": {
                        "enable": false
                    }
                },
                "size": {
                    "value": 5,
                    "random": true,
                    "anim": {
                        "enable": false
                    }
                },
                "line_linked": {
                    "enable": false
                },
                "move": {
                    "enable": true,
                    "speed": 5,
                    "direction": "bottom",
                    "random": true,
                    "straight": false,
                    "out_mode": "out",
                    "bounce": false,
                    "attract": {
                        "enable": true,
                        "rotateX": 300,
                        "rotateY": 1200
                    }
                }
            },
            "interactivity": {
                "events": {
                    "onhover": {
                        "enable": false
                    },
                    "onclick": {
                        "enable": false
                    },
                    "resize": false
                }
            },
            "retina_detect": true
        }), 3000);
	</script>
"""


# ╔═╡ 7758a2c0-7136-42eb-8b37-797418b1667b
md"
# Reinforcement learning
"

# ╔═╡ 99c6a6e8-6cb4-437d-856a-8e7125df7087
md"
Reinforcement Learning is an area of machine learning in which a learning agent learns, overtime, to behave optimally in a certain environment by interacting continuously in the environment.

It is one of three basic machine learning paradigms, alongside supervised learning and unsupervised learning.

During its course of learning, the agent experiences various different situations in the environment it is in. These are called states. The agent, while being in that state may choose from a set of allowable actions which may fetch different rewards(or penalties). The learning agent learns to maximize these rewards overtime so as to behave optimally at any given state it is in.
"

# ╔═╡ ef4e9d05-29c0-4c14-a4fa-93cc7ffb03cd
md"
# Q-learning
"

# ╔═╡ a10d3dd3-b8c5-4b85-9c7c-9241696e39e8
md"Q-Learning is a basic form of Reinforcement Learning which uses Q-values (also called action values) to iteratively improve the behavior of the learning agent."

# ╔═╡ 40ef4270-eb14-4f8a-9253-c8524eee49ad
md"
- Q-Values or Action-Values: Q-values are defined for states and actions. Q(S, A) is an estimation of how good is it to take the action A at the state S. This estimation of Q(S, A) will be iteratively computed using the TD- Update rule which we will see in the upcoming sections.

- Rewards and Episodes: An agent over the course of its lifetime starts from a start state, makes a number of transitions from its current state to a next state based on its choice of action and also the environment the agent is interacting in. At every step of transition, the agent from a state takes an action, observes a reward from the environment, and then transits to another state. If at any point of time the agent ends up in one of the terminating states that means there are no further transitions possible. This is said to be the completion of an episode.

- Temporal Difference or TD-Update:
The Temporal Difference or TD-Update rule can be represented as follows :

  new Q(S, A) = Q(S,A) + $$\alpha$$ R(S,A) + $$\gamma$$ Max Q'(S',A') - Q(S,A)
  
This update rule to estimate the value of Q is applied at every time step of the agents interaction with the environment. The terms used are explained below. :
	
S : Current State of the agent.
	
A : Current Action Picked according to some policy.
	
S' : Next State where the agent ends up.
	
A' : Next best action to be picked using current Q-value estimation, i.e. pick the action with the maximum Q-value in the next state.
	
R : Current Reward observed from the environment in Response of current action.
\
\
$\gamma$(>0 and <=1) : Discounting Factor for Future Rewards. Future rewards are less valuable than current rewards so they must be discounted. Since Q-value is an estimation of expected rewards from a state, discounting rule applies here as well. \
\
  $\alpha$: Step length taken to update the estimation of Q(S, A).

"

# ╔═╡ 80e0b4dc-c003-4263-abe2-8b8131684db8
md"
# Real life example
"

# ╔═╡ a402418e-7a5d-4471-beeb-0d82c9270abe
md"
To illustrate the concept of Q-learning, assume we have a guitar building factory. This factory has 9 different locations, with each having different guitar parts like polished wood sticks for the fretboard, polished wood for the guitar body, guitar pickups etc. We now want to build an autonomous robot that can find the shortest route from any given location to another location.

Below is given a picture of the lay-out of the factory. We can see that there are some obstacles in place, so e.g. the robot can't move from L1 to L4, nor from L6 to L9 and so on.


"

# ╔═╡ 0f1cbf49-8b8c-4e05-a6ac-cbb1a1d2f329
md"""
![]
(https://github.com/milanghe/STMOZOO/blob/main/image.png?raw=true)
"""

# ╔═╡ 24cd603c-6b69-4e09-97f9-20d64f388955
md"
The agent, in this case, is the robot. The environment is the guitar factory warehouse.

The location in which a particular robot is present in the particular instance of time will denote its state. 

The actions will be the direct locations that a robot can go to from a particular location e.g. a robot is at the L8 location and the direct locations to which it can move are L5, L7 and L9.

For each location, the set of actions that a robot can take will be different. For example, the set of actions will change if the robot is in L1.


"

# ╔═╡ 0732efd2-5ae5-4eb1-a04f-076182fce4ea
md"
The rewards, now, will be given to a robot if a location is directly reachable from a particular location. Let’s take an example:

L9 is directly reachable from L8. So, if a robot goes from L8 to L9 and vice-versa, it will be rewarded by 1. If a location is not directly reachable from a particular location, we do not give any reward (a reward of 0).

We can create a 9x9 matrix called a reward table in which we establish the possible connections between states. If there is a specific location that is very important for the robot to pass, we can assign a high value to this location. Assuming that e.g. L6 is a very important location we can assign it a value of 999 and get the following reward table:

"

# ╔═╡ 7428e585-a27c-4167-bd80-1887848b41f4
md"""
![]
(https://github.com/milanghe/STMOZOO/blob/main/reward-matrix-fixed.png?raw=true)
"""

# ╔═╡ 14ceb002-8d4f-4875-ad09-1aff458ec80d
md"
We now have to create a Q-table.
The Q-table represents a lookup table where we calculate the maximum expected future rewards for an action at each state. Basically, this table will guide us to the best action at each state.

We can do this by starting with an empty 9x9 array, picking a random state, calculating the Q-value of going from this state to a neighbouring state, updating our Q-table with this Q-value, and repeating this process a lot of times. 
"

# ╔═╡ c1025e5d-a853-4f61-8d8c-0a119888c176
md"""
# Implementation
"""

# ╔═╡ 74b76ae0-7a07-11ec-1915-4d1ac7528cfe
md"

We now want to implement the algorithm in Julia using our warehouse as example. The first thing we want to do is map the warehouse locations to different states.

"

# ╔═╡ 6082908d-735c-4065-8bc9-f2c556a92312
# Define the states
location_to_state = Dict(
    "L1" => 1,
    "L2" => 2,
    "L3" => 3,
    "L4" => 4,
    "L5" => 5,
    "L6" => 6,
    "L7" => 7,
    "L8" => 8,
    "L9" => 9
)

# ╔═╡ 1f3d25cf-3988-4ffe-8966-e395d1961cff
md"
We create the reward table:
"

# ╔═╡ f8a29471-755a-4478-8721-c3ca44273269
# Define the rewards
rewards = [0 1 0 0 0 0 0 0 0;
              1 0 1 0 0 0 0 0 0;
              0 1 0 0 0 1 0 0 0;
              0 0 0 0 0 0 1 0 0;
              0 1 0 0 0 0 0 1 0;
              0 0 1 0 0 0 0 0 0;
              0 0 0 1 0 0 0 1 0;
              0 0 0 0 1 0 1 0 1;
              0 0 0 0 0 0 0 1 0]

# ╔═╡ d751f0f3-c1a6-45fc-97ae-2cc98cc52275
md"
This reward table reflects the rewards the agent gets from transitioning from one state to the next. So e.g. if our agent transitions from L2 to L1 it gets a reward of 1 but if it transitions e.g. from L4 to L1 it gets a reward of 0 to discourage that path.
"

# ╔═╡ 3ac614fc-fbb9-4338-ba72-43c9ebcd2380
md"
Later on we will also need an inverse mapping from the states back to the original location indicators. This will be clearer when we write out the full algorithm.
"

# ╔═╡ 911fa693-3514-4f84-bc0e-86aca3888b9c
state_to_location = Dict(value => key for (key, value) in location_to_state)

# ╔═╡ 27fbd3f3-64bb-4f17-b733-2cc6db3fe24d
md"
We also define the two parameters of the Q-learning algorithm; ɑ (learning rate) and 𝜸 (discount factor).
"

# ╔═╡ c3976fb0-1d27-4d69-8449-17b255b2e387
alpha = 0.9 # Learning rate

# ╔═╡ df8e6091-4cd4-40fc-9086-9297c5fbca4f
gamma = 0.75 # Discount factor

# ╔═╡ fbe6a249-b6e1-4923-aed5-9be7c3fe4b78
md"
These hyperparameters can be adjusted to obtain a possible different result.
"

# ╔═╡ 08dfa166-c3d2-4534-ba7d-fbf3b20d29cf
md"
We will now create a function get_optimal_route(). This function will take two arguments, a starting location in the warehouse and the end location, and will return an ordered list with the optimal route between these two locations.
"

# ╔═╡ 09c720ed-6513-4602-a81a-170b7f4bc0a1
md"
We start defining our function by initializing the Q-values to be all zeros.
"

# ╔═╡ 497b305a-f5bb-4709-ac5d-d56b45593b02
Q = zeros(9,9)

# ╔═╡ bb77c2c0-f23c-488c-82c3-c224194e33f0
md"
For convenience, we will copy the rewards matrix to a separate variable and will operate on that.
"

# ╔═╡ 43a7938e-5c50-4a89-816f-e93fc6754c5d
rewards_new = rewards

# ╔═╡ 868f851e-74b2-4c56-b25c-02478ba4ae27
md"
Our function will take a starting and an ending location. We fetch the ending state from the location letter and set the priority of the ending location to a large value, e.g. 999
"

# ╔═╡ 7b1cb0f6-fe7a-4ae3-af6a-512bdd74b535
ending_state = location_to_state[end_location]

# ╔═╡ a59dddec-9fa8-4bd6-8ca6-72a6b9a91ad6
rewards_new[ending_state,ending_state] = 999

# ╔═╡ d31fac52-b8f0-4c53-9799-bc8deccadd8f
md"
Learning is a continuous process, hence we will let the robot explore the environment for a while and we will do it by simply looping through it 1000 times. We will then pick a state randomly from the set of states we defined above and we will call it current_state.
"

# ╔═╡ faa58e6d-7bb1-4de6-9335-a34d061f2744
for i in 1:1000
	current_state = rand(1:9)
end

# ╔═╡ 8d3529a4-6912-4f01-bde6-795b3f72b495
md"
We then, being inside the loop, iterate through the rewards matrix to get the states that are directly reachable from the randomly chosen current state and we will put those states in a list named playable_actions.

Note that so far we have not bothered about the starting location yet.
"

# ╔═╡ 00007c53-e3a2-4ae3-96e6-2f94d00b51bd
for i in 1:1000
	current_state = rand(1:9)
	playable_actions = []

	for j in 1:9
		if rewards_new[current_state,j] > 0
			push!(playable_actions,j)
		end
	end
end

# ╔═╡ e392ea1e-0ce8-40cb-b4fc-b4ef579a60bc
md"
We now randomly choose a reachable state from the playable_actions list
"

# ╔═╡ d066e1e8-ccc9-446c-b217-35a4d83a8282
next_state = rand(playable_actions)

# ╔═╡ cc16c79b-8003-48c1-9c62-d33e5c1521d0
md"
And update the Q-values using temporal difference:
Q_t(s,a) = Q_(t-1)(s,a) + $$\alpha$$TD_t(a,s)
"

# ╔═╡ c2697736-5013-476d-bfa7-3a64c56511f5
# Compute the temporal difference
TD = (rewards_new[current_state,next_state] + gamma * Q[next_state, 				argmax(Q[next_state,:])] - Q[current_state,next_state])

# ╔═╡ b740a7f5-c586-4052-a86d-c5ac7ef94511
# Update the Q-Value using the Bellman equation
Q[current_state,next_state] += alpha * TD

# ╔═╡ f8512361-4f42-4d40-a458-167ee2396ed3
md"
We are now done with the most important part of the algorithm and the code up to this point looks like this:
"

# ╔═╡ 5745cfe5-b664-40aa-9237-e665547f3eb2
begin
    function get_optimal_route_unfinished(start_location, end_location)
		rewards_new = rewards
		ending_state = location_to_state[end_location]
		rewards_new[ending_state,ending_state] = 999
		Q = zeros(9,9)

		for i in 1:1000
			current_state = rand(1:9)
			playable_actions = []

			for j in 1:9
				if rewards_new[current_state,j] > 0
					push!(playable_actions,j)
				end
			end
			next_state = rand(playable_actions)
			
			TD = (rewards_new[current_state,next_state] + gamma * Q[next_state, 				argmax(Q[next_state,:])] - Q[current_state,next_state])
			
			Q[current_state,next_state] += alpha * TD
			
		end
	end
end

# ╔═╡ 38b51d59-856e-4dd0-a96d-9dc6738a6c4c
md"
We now have an array of Q-values (Q-table). 
"

# ╔═╡ 6a3f74ad-be7b-4590-9fb0-e97ac76b257d
md"
For the second part of the algorithm, we start by initializing the optimal route with the starting location.
"

# ╔═╡ d1aed19d-1eed-405c-b3fd-b17d1498a4d5
route = [start_location]

# ╔═╡ c74008e0-af74-436f-9a75-377be8909868
md"
We currently do not know about the next move of the robot. Thus we will set the next location to also be the starting location.
"

# ╔═╡ f4a6868b-ea53-424e-8294-253941b0c4c9
next_location = start_location

# ╔═╡ c5b689ba-1dde-489d-a157-09fc4cbedc27
md"
Since we do not know the exact number of iterations the robot will take in order to find out the optimal route, we will simply loop the next set of processes until the next location is not equal to the ending location. This is where we will terminate the loop.
"

# ╔═╡ 1a8fac87-0fef-4bca-88be-cd2ac40dbe47
while next_location != end_location
	starting_state = location_to_state[start_location]
	next_state = argmax(Q[starting_state,:])
	next_location = state_to_location[next_state]
	push!(route, next_location)
	start_location = next_location
end

# ╔═╡ 7207ed8a-5270-4cc2-959d-e8a5b74d27a3
md"
Finally, we return the route
"

# ╔═╡ 460dac8b-66f8-435b-a716-28c4425235f6
return route

# ╔═╡ 671a41f2-ca45-4ebc-b371-16d19b8259d9
md"
Here is the whole get_optimal_route() function:
"

# ╔═╡ 3372480b-84d2-456c-bc75-a4f9c8154115
begin
    function get_optimal_route(start_location, end_location)
		rewards_new = rewards
		ending_state = location_to_state[end_location]
		rewards_new[ending_state,ending_state] = 999
		Q = zeros(9,9)

		for i in 1:1000
			current_state = rand(1:9)
			playable_actions = []

			for j in 1:9
				if rewards_new[current_state,j] > 0
					push!(playable_actions,j)
				end
			end
			next_state = rand(playable_actions)
			
			TD = (rewards_new[current_state,next_state] + gamma * Q[next_state, 				argmax(Q[next_state,:])] - Q[current_state,next_state])
			
			Q[current_state,next_state] += alpha * TD
			
		end
		
		route = [start_location]	
		next_location = start_location	

		while next_location != end_location
			starting_state = location_to_state[start_location]
			next_state = argmax(Q[starting_state,:])
			next_location = state_to_location[next_state]
			push!(route, next_location)
			start_location = next_location
		end

		return route
		
	end
end

# ╔═╡ 75c28554-542e-4dc9-be67-47e261f6f1dd
md"example showing the most optimal route from L9 to L1"

# ╔═╡ eb73ca3d-6447-4049-b921-cc9ba5a2d786
get_optimal_route("L9", "L1")

# ╔═╡ 74e414da-84bd-4d05-bc7d-d2849688e928
md"text and code inspired by: \
https://blog.floydhub.com/an-introduction-to-q-learning-reinforcement-learning/
\
\
https://www.geeksforgeeks.org/q-learning-in-python/#:~:text=Q%2DLearning%20is%20a%20basic,defined%20for%20states%20and%20actions.
\
\
https://en.wikipedia.org/wiki/Q-learning
"

# ╔═╡ Cell order:
# ╟─74b76ae0-7a07-11ec-2856-f1315c1e4b59
# ╟─7758a2c0-7136-42eb-8b37-797418b1667b
# ╟─99c6a6e8-6cb4-437d-856a-8e7125df7087
# ╟─ef4e9d05-29c0-4c14-a4fa-93cc7ffb03cd
# ╟─a10d3dd3-b8c5-4b85-9c7c-9241696e39e8
# ╟─40ef4270-eb14-4f8a-9253-c8524eee49ad
# ╟─80e0b4dc-c003-4263-abe2-8b8131684db8
# ╟─a402418e-7a5d-4471-beeb-0d82c9270abe
# ╟─0f1cbf49-8b8c-4e05-a6ac-cbb1a1d2f329
# ╟─24cd603c-6b69-4e09-97f9-20d64f388955
# ╟─0732efd2-5ae5-4eb1-a04f-076182fce4ea
# ╟─7428e585-a27c-4167-bd80-1887848b41f4
# ╟─14ceb002-8d4f-4875-ad09-1aff458ec80d
# ╟─c1025e5d-a853-4f61-8d8c-0a119888c176
# ╟─74b76ae0-7a07-11ec-1915-4d1ac7528cfe
# ╟─6082908d-735c-4065-8bc9-f2c556a92312
# ╟─1f3d25cf-3988-4ffe-8966-e395d1961cff
# ╟─f8a29471-755a-4478-8721-c3ca44273269
# ╟─d751f0f3-c1a6-45fc-97ae-2cc98cc52275
# ╟─3ac614fc-fbb9-4338-ba72-43c9ebcd2380
# ╠═911fa693-3514-4f84-bc0e-86aca3888b9c
# ╟─27fbd3f3-64bb-4f17-b733-2cc6db3fe24d
# ╟─c3976fb0-1d27-4d69-8449-17b255b2e387
# ╟─df8e6091-4cd4-40fc-9086-9297c5fbca4f
# ╟─fbe6a249-b6e1-4923-aed5-9be7c3fe4b78
# ╟─08dfa166-c3d2-4534-ba7d-fbf3b20d29cf
# ╟─09c720ed-6513-4602-a81a-170b7f4bc0a1
# ╠═497b305a-f5bb-4709-ac5d-d56b45593b02
# ╟─bb77c2c0-f23c-488c-82c3-c224194e33f0
# ╠═43a7938e-5c50-4a89-816f-e93fc6754c5d
# ╟─868f851e-74b2-4c56-b25c-02478ba4ae27
# ╟─7b1cb0f6-fe7a-4ae3-af6a-512bdd74b535
# ╟─a59dddec-9fa8-4bd6-8ca6-72a6b9a91ad6
# ╟─d31fac52-b8f0-4c53-9799-bc8deccadd8f
# ╠═faa58e6d-7bb1-4de6-9335-a34d061f2744
# ╟─8d3529a4-6912-4f01-bde6-795b3f72b495
# ╠═00007c53-e3a2-4ae3-96e6-2f94d00b51bd
# ╟─e392ea1e-0ce8-40cb-b4fc-b4ef579a60bc
# ╠═d066e1e8-ccc9-446c-b217-35a4d83a8282
# ╟─cc16c79b-8003-48c1-9c62-d33e5c1521d0
# ╠═c2697736-5013-476d-bfa7-3a64c56511f5
# ╠═b740a7f5-c586-4052-a86d-c5ac7ef94511
# ╟─f8512361-4f42-4d40-a458-167ee2396ed3
# ╠═5745cfe5-b664-40aa-9237-e665547f3eb2
# ╠═38b51d59-856e-4dd0-a96d-9dc6738a6c4c
# ╟─6a3f74ad-be7b-4590-9fb0-e97ac76b257d
# ╠═d1aed19d-1eed-405c-b3fd-b17d1498a4d5
# ╟─c74008e0-af74-436f-9a75-377be8909868
# ╠═f4a6868b-ea53-424e-8294-253941b0c4c9
# ╟─c5b689ba-1dde-489d-a157-09fc4cbedc27
# ╠═1a8fac87-0fef-4bca-88be-cd2ac40dbe47
# ╟─7207ed8a-5270-4cc2-959d-e8a5b74d27a3
# ╠═460dac8b-66f8-435b-a716-28c4425235f6
# ╟─671a41f2-ca45-4ebc-b371-16d19b8259d9
# ╠═3372480b-84d2-456c-bc75-a4f9c8154115
# ╟─75c28554-542e-4dc9-be67-47e261f6f1dd
# ╟─eb73ca3d-6447-4049-b921-cc9ba5a2d786
# ╟─74e414da-84bd-4d05-bc7d-d2849688e928
