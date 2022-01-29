### A Pluto.jl notebook ###
# v0.17.4

using Markdown
using InteractiveUtils

# ╔═╡ bbf94da8-cfa7-4dfe-9626-ae96a34fe9be
using Images

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

# ╔═╡ 475b51e9-de47-4d52-8a9b-1e0f0dac88a6

png_joinpathsplit__FILE__1assetsdownloadpng = let
    import PlutoUI
    PlutoUI.LocalResource(joinpath(split(@__FILE__, '#')[1] * ".assets", "download.png"))
end

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

# ╔═╡ 54c9af89-7205-4ea0-b0b6-095026286cbc
rewardmatrix = "C:/Users/ML/Desktop/reward-matrix-fixed.png"

# ╔═╡ 5f912a43-d114-4db9-a962-dc9ed82f6bf3
reward = load(rewardmatrix)

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

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Images = "916415d5-f1e6-5110-898d-aaa5f9f070e0"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
Images = "~0.25.1"
PlutoUI = "~0.7.30"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.7.1"
manifest_format = "2.0"

[[deps.AbstractFFTs]]
deps = ["ChainRulesCore", "LinearAlgebra"]
git-tree-sha1 = "6f1d9bc1c08f9f4a8fa92e3ea3cb50153a1b40d4"
uuid = "621f4979-c628-5d54-868e-fcf4e3e8185c"
version = "1.1.0"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "8eaf9f1b4921132a4cff3f36a1d9ba923b14a481"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.4"

[[deps.Adapt]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "af92965fb30777147966f58acb05da51c5616b5f"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "3.3.3"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[deps.ArnoldiMethod]]
deps = ["LinearAlgebra", "Random", "StaticArrays"]
git-tree-sha1 = "62e51b39331de8911e4a7ff6f5aaf38a5f4cc0ae"
uuid = "ec485272-7323-5ecc-a04f-4719b315124d"
version = "0.2.0"

[[deps.ArrayInterface]]
deps = ["Compat", "IfElse", "LinearAlgebra", "Requires", "SparseArrays", "Static"]
git-tree-sha1 = "ffc6588e17bcfcaa79dfa5b4f417025e755f83fc"
uuid = "4fba245c-0d91-5ea0-9b3e-6abc04ee57a9"
version = "4.0.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.AxisAlgorithms]]
deps = ["LinearAlgebra", "Random", "SparseArrays", "WoodburyMatrices"]
git-tree-sha1 = "66771c8d21c8ff5e3a93379480a2307ac36863f7"
uuid = "13072b0f-2c55-5437-9ae7-d433b7a33950"
version = "1.0.1"

[[deps.AxisArrays]]
deps = ["Dates", "IntervalSets", "IterTools", "RangeArrays"]
git-tree-sha1 = "d127d5e4d86c7680b20c35d40b503c74b9a39b5e"
uuid = "39de3d68-74b9-583c-8d2d-e117c070f3a9"
version = "0.4.4"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.CEnum]]
git-tree-sha1 = "215a9aa4a1f23fbd05b92769fdd62559488d70e9"
uuid = "fa961155-64e5-5f13-b03f-caf6b980ea82"
version = "0.4.1"

[[deps.Calculus]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "f641eb0a4f00c343bbc32346e1217b86f3ce9dad"
uuid = "49dc2e85-a5d0-5ad3-a950-438e2897f1b9"
version = "0.5.1"

[[deps.CatIndices]]
deps = ["CustomUnitRanges", "OffsetArrays"]
git-tree-sha1 = "a0f80a09780eed9b1d106a1bf62041c2efc995bc"
uuid = "aafaddc9-749c-510e-ac4f-586e18779b91"
version = "0.2.2"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "54fc4400de6e5c3e27be6047da2ef6ba355511f8"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.11.6"

[[deps.ChangesOfVariables]]
deps = ["ChainRulesCore", "LinearAlgebra", "Test"]
git-tree-sha1 = "bf98fa45a0a4cee295de98d4c1462be26345b9a1"
uuid = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
version = "0.1.2"

[[deps.Clustering]]
deps = ["Distances", "LinearAlgebra", "NearestNeighbors", "Printf", "SparseArrays", "Statistics", "StatsBase"]
git-tree-sha1 = "75479b7df4167267d75294d14b58244695beb2ac"
uuid = "aaaa29a8-35af-508c-8bc3-b662a17a0fe5"
version = "0.14.2"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "024fe24d83e4a5bf5fc80501a314ce0d1aa35597"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.0"

[[deps.ColorVectorSpace]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "SpecialFunctions", "Statistics", "TensorCore"]
git-tree-sha1 = "3f1f500312161f1ae067abe07d13b40f78f32e07"
uuid = "c3611d14-8923-5661-9e6a-0046d554d3a4"
version = "0.9.8"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "417b0ed7b8b838aa6ca0a87aadf1bb9eb111ce40"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.8"

[[deps.Compat]]
deps = ["Base64", "Dates", "DelimitedFiles", "Distributed", "InteractiveUtils", "LibGit2", "Libdl", "LinearAlgebra", "Markdown", "Mmap", "Pkg", "Printf", "REPL", "Random", "SHA", "Serialization", "SharedArrays", "Sockets", "SparseArrays", "Statistics", "Test", "UUIDs", "Unicode"]
git-tree-sha1 = "44c37b4636bc54afac5c574d2d02b625349d6582"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "3.41.0"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

[[deps.ComputationalResources]]
git-tree-sha1 = "52cb3ec90e8a8bea0e62e275ba577ad0f74821f7"
uuid = "ed09eef8-17a6-5b46-8889-db040fac31e3"
version = "0.3.2"

[[deps.CoordinateTransformations]]
deps = ["LinearAlgebra", "StaticArrays"]
git-tree-sha1 = "681ea870b918e7cff7111da58791d7f718067a19"
uuid = "150eb455-5306-5404-9cee-2592286d6298"
version = "0.6.2"

[[deps.CustomUnitRanges]]
git-tree-sha1 = "1a3f97f907e6dd8983b744d2642651bb162a3f7a"
uuid = "dc8bdbbb-1ca9-579f-8c36-e416f6a65cce"
version = "1.0.2"

[[deps.DataAPI]]
git-tree-sha1 = "cc70b17275652eb47bc9e5f81635981f13cea5c8"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.9.0"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "3daef5523dd2e769dad2365274f760ff5f282c7d"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.11"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"

[[deps.Distances]]
deps = ["LinearAlgebra", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "3258d0659f812acde79e8a74b11f17ac06d0ca04"
uuid = "b4f34e82-e78d-54a5-968a-f98e89d6e8f7"
version = "0.10.7"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "b19534d1895d702889b219c382a6e18010797f0b"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.8.6"

[[deps.Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[deps.DualNumbers]]
deps = ["Calculus", "NaNMath", "SpecialFunctions"]
git-tree-sha1 = "84f04fe68a3176a583b864e492578b9466d87f1e"
uuid = "fa6b7ba4-c1ee-5f82-b5fc-ecf0adba8f74"
version = "0.6.6"

[[deps.EllipsisNotation]]
deps = ["ArrayInterface"]
git-tree-sha1 = "d7ab55febfd0907b285fbf8dc0c73c0825d9d6aa"
uuid = "da5c29d0-fa7d-589e-88eb-ea29b0a81949"
version = "1.3.0"

[[deps.FFTViews]]
deps = ["CustomUnitRanges", "FFTW"]
git-tree-sha1 = "cbdf14d1e8c7c8aacbe8b19862e0179fd08321c2"
uuid = "4f61f5a4-77b1-5117-aa51-3ab5ef4ef0cd"
version = "0.3.2"

[[deps.FFTW]]
deps = ["AbstractFFTs", "FFTW_jll", "LinearAlgebra", "MKL_jll", "Preferences", "Reexport"]
git-tree-sha1 = "463cb335fa22c4ebacfd1faba5fde14edb80d96c"
uuid = "7a1cc6ca-52ef-59f5-83cd-3a7055c09341"
version = "1.4.5"

[[deps.FFTW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c6033cc3892d0ef5bb9cd29b7f2f0331ea5184ea"
uuid = "f5851436-0d7a-5f13-b9de-f02708fd171a"
version = "3.3.10+0"

[[deps.FileIO]]
deps = ["Pkg", "Requires", "UUIDs"]
git-tree-sha1 = "67551df041955cc6ee2ed098718c8fcd7fc7aebe"
uuid = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
version = "1.12.0"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Graphics]]
deps = ["Colors", "LinearAlgebra", "NaNMath"]
git-tree-sha1 = "1c5a84319923bea76fa145d49e93aa4394c73fc2"
uuid = "a2bd30eb-e257-5431-a919-1863eab51364"
version = "1.1.1"

[[deps.Graphs]]
deps = ["ArnoldiMethod", "Compat", "DataStructures", "Distributed", "Inflate", "LinearAlgebra", "Random", "SharedArrays", "SimpleTraits", "SparseArrays", "Statistics"]
git-tree-sha1 = "d727758173afef0af878b29ac364a0eca299fc6b"
uuid = "86223c79-3864-5bf0-83f7-82e725a168b6"
version = "1.5.1"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[deps.HypertextLiteral]]
git-tree-sha1 = "2b078b5a615c6c0396c77810d92ee8c6f470d238"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.3"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "f7be53659ab06ddc986428d3a9dcc95f6fa6705a"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.2"

[[deps.IfElse]]
git-tree-sha1 = "debdd00ffef04665ccbb3e150747a77560e8fad1"
uuid = "615f187c-cbe4-4ef1-ba3b-2fcf58d6d173"
version = "0.1.1"

[[deps.ImageAxes]]
deps = ["AxisArrays", "ImageBase", "ImageCore", "Reexport", "SimpleTraits"]
git-tree-sha1 = "c54b581a83008dc7f292e205f4c409ab5caa0f04"
uuid = "2803e5a7-5153-5ecf-9a86-9b4c37f5f5ac"
version = "0.6.10"

[[deps.ImageBase]]
deps = ["ImageCore", "Reexport"]
git-tree-sha1 = "b51bb8cae22c66d0f6357e3bcb6363145ef20835"
uuid = "c817782e-172a-44cc-b673-b171935fbb9e"
version = "0.1.5"

[[deps.ImageContrastAdjustment]]
deps = ["ImageCore", "ImageTransformations", "Parameters"]
git-tree-sha1 = "0d75cafa80cf22026cea21a8e6cf965295003edc"
uuid = "f332f351-ec65-5f6a-b3d1-319c6670881a"
version = "0.3.10"

[[deps.ImageCore]]
deps = ["AbstractFFTs", "ColorVectorSpace", "Colors", "FixedPointNumbers", "Graphics", "MappedArrays", "MosaicViews", "OffsetArrays", "PaddedViews", "Reexport"]
git-tree-sha1 = "9a5c62f231e5bba35695a20988fc7cd6de7eeb5a"
uuid = "a09fc81d-aa75-5fe9-8630-4744c3626534"
version = "0.9.3"

[[deps.ImageDistances]]
deps = ["Distances", "ImageCore", "ImageMorphology", "LinearAlgebra", "Statistics"]
git-tree-sha1 = "7a20463713d239a19cbad3f6991e404aca876bda"
uuid = "51556ac3-7006-55f5-8cb3-34580c88182d"
version = "0.2.15"

[[deps.ImageFiltering]]
deps = ["CatIndices", "ComputationalResources", "DataStructures", "FFTViews", "FFTW", "ImageBase", "ImageCore", "LinearAlgebra", "OffsetArrays", "Reexport", "SparseArrays", "StaticArrays", "Statistics", "TiledIteration"]
git-tree-sha1 = "15bd05c1c0d5dbb32a9a3d7e0ad2d50dd6167189"
uuid = "6a3955dd-da59-5b1f-98d4-e7296123deb5"
version = "0.7.1"

[[deps.ImageIO]]
deps = ["FileIO", "Netpbm", "OpenEXR", "PNGFiles", "QOI", "Sixel", "TiffImages", "UUIDs"]
git-tree-sha1 = "816fc866edd8307a6e79a575e6585bfab8cef27f"
uuid = "82e4d734-157c-48bb-816b-45c225c6df19"
version = "0.6.0"

[[deps.ImageMagick]]
deps = ["FileIO", "ImageCore", "ImageMagick_jll", "InteractiveUtils"]
git-tree-sha1 = "ca8d917903e7a1126b6583a097c5cb7a0bedeac1"
uuid = "6218d12a-5da1-5696-b52f-db25d2ecc6d1"
version = "1.2.2"

[[deps.ImageMagick_jll]]
deps = ["JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pkg", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "1c0a2295cca535fabaf2029062912591e9b61987"
uuid = "c73af94c-d91f-53ed-93a7-00f77d67a9d7"
version = "6.9.10-12+3"

[[deps.ImageMetadata]]
deps = ["AxisArrays", "ImageAxes", "ImageBase", "ImageCore"]
git-tree-sha1 = "36cbaebed194b292590cba2593da27b34763804a"
uuid = "bc367c6b-8a6b-528e-b4bd-a4b897500b49"
version = "0.9.8"

[[deps.ImageMorphology]]
deps = ["ImageCore", "LinearAlgebra", "Requires", "TiledIteration"]
git-tree-sha1 = "5581e18a74a5838bd919294a7138c2663d065238"
uuid = "787d08f9-d448-5407-9aad-5290dd7ab264"
version = "0.3.0"

[[deps.ImageQualityIndexes]]
deps = ["ImageContrastAdjustment", "ImageCore", "ImageDistances", "ImageFiltering", "OffsetArrays", "Statistics"]
git-tree-sha1 = "1d2d73b14198d10f7f12bf7f8481fd4b3ff5cd61"
uuid = "2996bd0c-7a13-11e9-2da2-2f5ce47296a9"
version = "0.3.0"

[[deps.ImageSegmentation]]
deps = ["Clustering", "DataStructures", "Distances", "Graphs", "ImageCore", "ImageFiltering", "ImageMorphology", "LinearAlgebra", "MetaGraphs", "RegionTrees", "SimpleWeightedGraphs", "StaticArrays", "Statistics"]
git-tree-sha1 = "36832067ea220818d105d718527d6ed02385bf22"
uuid = "80713f31-8817-5129-9cf8-209ff8fb23e1"
version = "1.7.0"

[[deps.ImageShow]]
deps = ["Base64", "FileIO", "ImageBase", "ImageCore", "OffsetArrays", "StackViews"]
git-tree-sha1 = "d0ac64c9bee0aed6fdbb2bc0e5dfa9a3a78e3acc"
uuid = "4e3cecfd-b093-5904-9786-8bbb286a6a31"
version = "0.3.3"

[[deps.ImageTransformations]]
deps = ["AxisAlgorithms", "ColorVectorSpace", "CoordinateTransformations", "ImageBase", "ImageCore", "Interpolations", "OffsetArrays", "Rotations", "StaticArrays"]
git-tree-sha1 = "42fe8de1fe1f80dab37a39d391b6301f7aeaa7b8"
uuid = "02fcd773-0e25-5acc-982a-7f6622650795"
version = "0.9.4"

[[deps.Images]]
deps = ["Base64", "FileIO", "Graphics", "ImageAxes", "ImageBase", "ImageContrastAdjustment", "ImageCore", "ImageDistances", "ImageFiltering", "ImageIO", "ImageMagick", "ImageMetadata", "ImageMorphology", "ImageQualityIndexes", "ImageSegmentation", "ImageShow", "ImageTransformations", "IndirectArrays", "IntegralArrays", "Random", "Reexport", "SparseArrays", "StaticArrays", "Statistics", "StatsBase", "TiledIteration"]
git-tree-sha1 = "11d268adba1869067620659e7cdf07f5e54b6c76"
uuid = "916415d5-f1e6-5110-898d-aaa5f9f070e0"
version = "0.25.1"

[[deps.Imath_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "87f7662e03a649cffa2e05bf19c303e168732d3e"
uuid = "905a6f67-0a94-5f89-b386-d35d92009cd1"
version = "3.1.2+0"

[[deps.IndirectArrays]]
git-tree-sha1 = "012e604e1c7458645cb8b436f8fba789a51b257f"
uuid = "9b13fd28-a010-5f03-acff-a1bbcff69959"
version = "1.0.0"

[[deps.Inflate]]
git-tree-sha1 = "f5fc07d4e706b84f72d54eedcc1c13d92fb0871c"
uuid = "d25df0c9-e2be-5dd7-82c8-3ad0b3e990b9"
version = "0.1.2"

[[deps.IntegralArrays]]
deps = ["ColorTypes", "FixedPointNumbers", "IntervalSets"]
git-tree-sha1 = "00019244715621f473d399e4e1842e479a69a42e"
uuid = "1d092043-8f09-5a30-832f-7509e371ab51"
version = "0.1.2"

[[deps.IntelOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "d979e54b71da82f3a65b62553da4fc3d18c9004c"
uuid = "1d5cc7b8-4909-519e-a0f8-d0f5ad9712d0"
version = "2018.0.3+2"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.Interpolations]]
deps = ["AxisAlgorithms", "ChainRulesCore", "LinearAlgebra", "OffsetArrays", "Random", "Ratios", "Requires", "SharedArrays", "SparseArrays", "StaticArrays", "WoodburyMatrices"]
git-tree-sha1 = "b15fc0a95c564ca2e0a7ae12c1f095ca848ceb31"
uuid = "a98d9a8b-a2ab-59e6-89dd-64a1c18fca59"
version = "0.13.5"

[[deps.IntervalSets]]
deps = ["Dates", "EllipsisNotation", "Statistics"]
git-tree-sha1 = "3cc368af3f110a767ac786560045dceddfc16758"
uuid = "8197267c-284f-5f27-9208-e0e47529a953"
version = "0.5.3"

[[deps.InverseFunctions]]
deps = ["Test"]
git-tree-sha1 = "a7254c0acd8e62f1ac75ad24d5db43f5f19f3c65"
uuid = "3587e190-3f89-42d0-90ee-14403ec27112"
version = "0.1.2"

[[deps.IrrationalConstants]]
git-tree-sha1 = "7fd44fd4ff43fc60815f8e764c0f352b83c49151"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.1.1"

[[deps.IterTools]]
git-tree-sha1 = "fa6287a4469f5e048d763df38279ee729fbd44e5"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.4.0"

[[deps.JLD2]]
deps = ["DataStructures", "FileIO", "MacroTools", "Mmap", "Pkg", "Printf", "Reexport", "TranscodingStreams", "UUIDs"]
git-tree-sha1 = "09ef0c32a26f80b465d808a1ba1e85775a282c97"
uuid = "033835bb-8acc-5ee8-8aae-3f567f8a3819"
version = "0.4.17"

[[deps.JLLWrappers]]
deps = ["Preferences"]
git-tree-sha1 = "22df5b96feef82434b07327e2d3c770a9b21e023"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.4.0"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "8076680b162ada2a031f707ac7b4953e30667a37"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.2"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "d735490ac75c5cb9f1b00d8b5509c11984dc6943"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "2.1.0+0"

[[deps.LazyArtifacts]]
deps = ["Artifacts", "Pkg"]
uuid = "4af54fe1-eca0-43a8-85a7-787d91b784e3"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Pkg", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "340e257aada13f95f98ee352d316c3bed37c8ab9"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.3.0+0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.LogExpFunctions]]
deps = ["ChainRulesCore", "ChangesOfVariables", "DocStringExtensions", "InverseFunctions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "e5718a00af0ab9756305a0392832c8952c7426c1"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.6"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.MKL_jll]]
deps = ["Artifacts", "IntelOpenMP_jll", "JLLWrappers", "LazyArtifacts", "Libdl", "Pkg"]
git-tree-sha1 = "5455aef09b40e5020e1520f551fa3135040d4ed0"
uuid = "856f044c-d86e-5d09-b602-aeab76dc8ba7"
version = "2021.1.1+2"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "3d3e902b31198a27340d0bf00d6ac452866021cf"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.9"

[[deps.MappedArrays]]
git-tree-sha1 = "e8b359ef06ec72e8c030463fe02efe5527ee5142"
uuid = "dbb5928d-eab1-5f90-85c2-b9b0edb7c900"
version = "0.4.1"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[deps.MetaGraphs]]
deps = ["Graphs", "JLD2", "Random"]
git-tree-sha1 = "2af69ff3c024d13bde52b34a2a7d6887d4e7b438"
uuid = "626554b9-1ddb-594c-aa3c-2596fe9399a5"
version = "0.7.1"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "bf210ce90b6c9eed32d25dbcae1ebc565df2687f"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.0.2"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MosaicViews]]
deps = ["MappedArrays", "OffsetArrays", "PaddedViews", "StackViews"]
git-tree-sha1 = "b34e3bc3ca7c94914418637cb10cc4d1d80d877d"
uuid = "e94cdb99-869f-56ef-bcf0-1ae2bcbe0389"
version = "0.3.3"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[deps.NaNMath]]
git-tree-sha1 = "f755f36b19a5116bb580de457cda0c140153f283"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "0.3.6"

[[deps.NearestNeighbors]]
deps = ["Distances", "StaticArrays"]
git-tree-sha1 = "16baacfdc8758bc374882566c9187e785e85c2f0"
uuid = "b8a86587-4115-5ab1-83bc-aa920d37bbce"
version = "0.4.9"

[[deps.Netpbm]]
deps = ["FileIO", "ImageCore"]
git-tree-sha1 = "18efc06f6ec36a8b801b23f076e3c6ac7c3bf153"
uuid = "f09324ee-3d7c-5217-9330-fc30815ba969"
version = "1.0.2"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[deps.OffsetArrays]]
deps = ["Adapt"]
git-tree-sha1 = "043017e0bdeff61cfbb7afeb558ab29536bbb5ed"
uuid = "6fe1bfb0-de20-5000-8ca7-80f57d26f881"
version = "1.10.8"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"

[[deps.OpenEXR]]
deps = ["Colors", "FileIO", "OpenEXR_jll"]
git-tree-sha1 = "327f53360fdb54df7ecd01e96ef1983536d1e633"
uuid = "52e1d378-f018-4a11-a4be-720524705ac7"
version = "0.3.2"

[[deps.OpenEXR_jll]]
deps = ["Artifacts", "Imath_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "923319661e9a22712f24596ce81c54fc0366f304"
uuid = "18a262bb-aa17-5467-a713-aee519bc75cb"
version = "3.1.1+0"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "13652491f6856acfd2db29360e1bbcd4565d04f1"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.5+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

[[deps.PNGFiles]]
deps = ["Base64", "CEnum", "ImageCore", "IndirectArrays", "OffsetArrays", "libpng_jll"]
git-tree-sha1 = "6d105d40e30b635cfed9d52ec29cf456e27d38f8"
uuid = "f57f5aa1-a3ce-4bc8-8ab9-96f992907883"
version = "0.3.12"

[[deps.PaddedViews]]
deps = ["OffsetArrays"]
git-tree-sha1 = "03a7a85b76381a3d04c7a1656039197e70eda03d"
uuid = "5432bcbf-9aad-5242-b902-cca2824c8663"
version = "0.5.11"

[[deps.Parameters]]
deps = ["OrderedCollections", "UnPack"]
git-tree-sha1 = "34c0e9ad262e5f7fc75b10a9952ca7692cfc5fbe"
uuid = "d96e819e-fc66-5662-9728-84c9c7592b0a"
version = "0.12.3"

[[deps.Parsers]]
deps = ["Dates"]
git-tree-sha1 = "92f91ba9e5941fc781fecf5494ac1da87bdac775"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.2.0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[deps.PkgVersion]]
deps = ["Pkg"]
git-tree-sha1 = "a7a7e1a88853564e551e4eba8650f8c38df79b37"
uuid = "eebad327-c553-4316-9ea0-9fa01ccd7688"
version = "0.1.1"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "5c0eb9099596090bb3215260ceca687b888a1575"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.30"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "2cf929d64681236a2e074ffafb8d568733d2e6af"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.2.3"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.ProgressMeter]]
deps = ["Distributed", "Printf"]
git-tree-sha1 = "afadeba63d90ff223a6a48d2009434ecee2ec9e8"
uuid = "92933f4c-e287-5a05-a399-4b506db050ca"
version = "1.7.1"

[[deps.QOI]]
deps = ["ColorTypes", "FileIO", "FixedPointNumbers"]
git-tree-sha1 = "18e8f4d1426e965c7b532ddd260599e1510d26ce"
uuid = "4b34888f-f399-49d4-9bb3-47ed5cae4e65"
version = "1.0.0"

[[deps.Quaternions]]
deps = ["DualNumbers", "LinearAlgebra"]
git-tree-sha1 = "adf644ef95a5e26c8774890a509a55b7791a139f"
uuid = "94ee1d12-ae83-5a48-8b1c-48b8ff168ae0"
version = "0.4.2"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.RangeArrays]]
git-tree-sha1 = "b9039e93773ddcfc828f12aadf7115b4b4d225f5"
uuid = "b3c3ace0-ae52-54e7-9d0b-2c1406fd6b9d"
version = "0.3.2"

[[deps.Ratios]]
deps = ["Requires"]
git-tree-sha1 = "01d341f502250e81f6fec0afe662aa861392a3aa"
uuid = "c84ed2f1-dad5-54f0-aa8e-dbefe2724439"
version = "0.4.2"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.RegionTrees]]
deps = ["IterTools", "LinearAlgebra", "StaticArrays"]
git-tree-sha1 = "4618ed0da7a251c7f92e869ae1a19c74a7d2a7f9"
uuid = "dee08c22-ab7f-5625-9660-a9af2021b33f"
version = "0.3.2"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.Rotations]]
deps = ["LinearAlgebra", "Quaternions", "Random", "StaticArrays", "Statistics"]
git-tree-sha1 = "2fa87d198bc5356c649b92109ed3ce46ee1eb89d"
uuid = "6038ab10-8711-5258-84ad-4b1120ba62dc"
version = "1.1.1"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[deps.SimpleTraits]]
deps = ["InteractiveUtils", "MacroTools"]
git-tree-sha1 = "5d7e3f4e11935503d3ecaf7186eac40602e7d231"
uuid = "699a6c99-e7fa-54fc-8d76-47d257e15c1d"
version = "0.9.4"

[[deps.SimpleWeightedGraphs]]
deps = ["Graphs", "LinearAlgebra", "Markdown", "SparseArrays", "Test"]
git-tree-sha1 = "a6f404cc44d3d3b28c793ec0eb59af709d827e4e"
uuid = "47aef6b3-ad0c-573a-a1e2-d07658019622"
version = "1.2.1"

[[deps.Sixel]]
deps = ["Dates", "FileIO", "ImageCore", "IndirectArrays", "OffsetArrays", "REPL", "libsixel_jll"]
git-tree-sha1 = "8fb59825be681d451c246a795117f317ecbcaa28"
uuid = "45858cf5-a6b0-47a3-bbea-62219f50df47"
version = "0.1.2"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "b3363d7460f7d098ca0912c69b082f75625d7508"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.0.1"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.SpecialFunctions]]
deps = ["ChainRulesCore", "IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "e08890d19787ec25029113e88c34ec20cac1c91e"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.0.0"

[[deps.StackViews]]
deps = ["OffsetArrays"]
git-tree-sha1 = "46e589465204cd0c08b4bd97385e4fa79a0c770c"
uuid = "cae243ae-269e-4f55-b966-ac2d0dc13c15"
version = "0.1.1"

[[deps.Static]]
deps = ["IfElse"]
git-tree-sha1 = "b4912cd034cdf968e06ca5f943bb54b17b97793a"
uuid = "aedffcd0-7271-4cad-89d0-dc628f76c6d3"
version = "0.5.1"

[[deps.StaticArrays]]
deps = ["LinearAlgebra", "Random", "Statistics"]
git-tree-sha1 = "2ae4fe21e97cd13efd857462c1869b73c9f61be3"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.3.2"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.StatsAPI]]
git-tree-sha1 = "d88665adc9bcf45903013af0982e2fd05ae3d0a6"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.2.0"

[[deps.StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "51383f2d367eb3b444c961d485c565e4c0cf4ba0"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.33.14"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

[[deps.TensorCore]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1feb45f88d133a655e001435632f019a9a1bcdb6"
uuid = "62fd8b95-f654-4bbd-a8a5-9c27f68ccd50"
version = "0.1.1"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.TiffImages]]
deps = ["ColorTypes", "DataStructures", "DocStringExtensions", "FileIO", "FixedPointNumbers", "IndirectArrays", "Inflate", "OffsetArrays", "PkgVersion", "ProgressMeter", "UUIDs"]
git-tree-sha1 = "991d34bbff0d9125d93ba15887d6594e8e84b305"
uuid = "731e570b-9d59-4bfa-96dc-6df516fadf69"
version = "0.5.3"

[[deps.TiledIteration]]
deps = ["OffsetArrays"]
git-tree-sha1 = "5683455224ba92ef59db72d10690690f4a8dc297"
uuid = "06e1c1a7-607b-532d-9fad-de7d9aa2abac"
version = "0.3.1"

[[deps.TranscodingStreams]]
deps = ["Random", "Test"]
git-tree-sha1 = "216b95ea110b5972db65aa90f88d8d89dcb8851c"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.9.6"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.UnPack]]
git-tree-sha1 = "387c1f73762231e86e0c9c5443ce3b4a0a9a0c2b"
uuid = "3a884ed6-31ef-47d7-9d2a-63182c4928ed"
version = "1.0.2"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.WoodburyMatrices]]
deps = ["LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "de67fa59e33ad156a590055375a30b23c40299d3"
uuid = "efce3f68-66dc-5838-9240-27a6d6f5f9b6"
version = "0.5.5"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"

[[deps.Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "cc4bf3fdde8b7e3e9fa0351bdeedba1cf3b7f6e6"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.0+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "94d180a6d2b5e55e447e2d27a29ed04fe79eb30c"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.38+0"

[[deps.libsixel_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "78736dab31ae7a53540a6b752efc61f77b304c5b"
uuid = "075b6546-f08a-558a-be8f-8157d0f608a5"
version = "1.8.6+1"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
"""

# ╔═╡ Cell order:
# ╟─74b76ae0-7a07-11ec-2856-f1315c1e4b59
# ╟─7758a2c0-7136-42eb-8b37-797418b1667b
# ╠═99c6a6e8-6cb4-437d-856a-8e7125df7087
# ╟─ef4e9d05-29c0-4c14-a4fa-93cc7ffb03cd
# ╟─a10d3dd3-b8c5-4b85-9c7c-9241696e39e8
# ╟─40ef4270-eb14-4f8a-9253-c8524eee49ad
# ╟─80e0b4dc-c003-4263-abe2-8b8131684db8
# ╟─a402418e-7a5d-4471-beeb-0d82c9270abe
# ╟─475b51e9-de47-4d52-8a9b-1e0f0dac88a6
# ╟─24cd603c-6b69-4e09-97f9-20d64f388955
# ╟─0732efd2-5ae5-4eb1-a04f-076182fce4ea
# ╠═bbf94da8-cfa7-4dfe-9626-ae96a34fe9be
# ╠═54c9af89-7205-4ea0-b0b6-095026286cbc
# ╠═5f912a43-d114-4db9-a962-dc9ed82f6bf3
# ╠═14ceb002-8d4f-4875-ad09-1aff458ec80d
# ╠═c1025e5d-a853-4f61-8d8c-0a119888c176
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
# ╠═671a41f2-ca45-4ebc-b371-16d19b8259d9
# ╠═3372480b-84d2-456c-bc75-a4f9c8154115
# ╟─75c28554-542e-4dc9-be67-47e261f6f1dd
# ╟─eb73ca3d-6447-4049-b921-cc9ba5a2d786
# ╟─74e414da-84bd-4d05-bc7d-d2849688e928
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
