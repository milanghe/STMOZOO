### A Pluto.jl notebook ###
# v0.17.4

using Markdown
using InteractiveUtils

# ╔═╡ bbbb4e00-691f-11ec-36a7-117d098001a2
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


# ╔═╡ ef140ba1-1ecf-4290-acf4-322d622ae260
md"""
# INTRODUCTION TO Q-LEARNING WITH JULIA
"""

# ╔═╡ dae558db-a01b-4e60-a4ec-93d20556d56d
md"Reinforcement learning is a branch of Machine Learning that trains a model to come to an optimum solution for a problem by taking decisions by itself. 

It consists of:

An Environment, which an agent will interact with, to learn to reach a goal or perform an action.

A Reward if the action performed by the model is bringing us closer to the goal/is leading to the goal. This is done to train the model in the right direction.

A negative reward if it performs an action that will not lead to the goal to prevent it from learning in the wrong direction.

Reinforcement learning requires a machine learning model to learn from the problem and come up with the most optimal solution by itself. This means that we also arrive at fast and unique solutions which the programmer might not even have thought of.

Q-Learning is a Reinforcement learning policy that will find the next best action, given a current state. It chooses this action at random and aims to maximize the reward.

Q-learning is a model-free, off-policy reinforcement learning that will find the best course of action, given the current state of the agent. Depending on where the agent is in the environment, it will decide the next action to be taken. 

The objective of the model is to find the best course of action given its current state. To do this, it may come up with rules of its own or it may operate outside the policy given to it to follow. This means that there is no actual need for a policy, hence we call it off-policy.

Model-free means that the agent uses predictions of the environment’s expected response to move forward. It does not use the reward system to learn, but rather, trial and error.

An example of Q-learning is an Advertisement recommendation system. In a normal ad recommendation system, the ads you get are based on your previous purchases or websites you may have visited. If you’ve bought a TV, you will get recommended TVs of different brands. 

Using Q-learning, we can optimize the ad recommendation system to recommend products that are frequently bought together. The reward will be if the user clicks on the suggested product."

# ╔═╡ f677c230-4816-4cf1-adb3-9603c8b3b8ed
md"""
# Important Terms in Q-Learning

States: The State, S, represents the current position of an agent in an environment. 

Action: The Action, A, is the step taken by the agent when it is in a particular state.

Rewards: For every action, the agent will get a positive or negative reward.

Episodes: When an agent ends up in a terminating state and can’t take a new action.

Q-Values: Used to determine how good an Action, A, taken at a particular state, S, is. Q (A, S).

Temporal Difference: A formula used to find the Q-Value by using the value of current state and action and previous state and action.

"""

# ╔═╡ a297c034-edcb-4d0b-a57b-610268566e2c
md"""
# Bellman equation

The Bellman Equation is used to determine the value of a particular state and deduce how good it is to be in/take that state. The optimal state will give us the highest optimal value. 

The equation is given below. It uses the current state, and the reward associated with that state, along with the maximum expected reward and a discount rate, which determines its importance to the current state, to find the next state of our agent. The learning rate determines how fast or slow, the model will be learning. 

new Q(S, A) = Q(S,A) + $$\alpha$$ R(S,A) + $$\gamma$$ Max Q'(S',A') - Q(S,A)

with 
Q(S,A) = current Q value \
$$\alpha$$ = learning rate \
R(S,A) the reward \
$$\gamma$$ = the discount rate \
Max Q'(S',A') = the maximum expected future reward

"""

# ╔═╡ a119d090-9f01-4028-b93d-6cee215173e8
md"""
# Example implementation
"""

# ╔═╡ 9e3e3f5b-e92d-4fca-a741-8241c46bd4ec
md"We are to build a few autonomous robots for a guitar building factory. These robots will help the guitar luthiers by conveying them the necessary guitar parts that they would need in order to craft a guitar. These different parts are located at nine different positions within the factory warehouse. Guitars parts include polished wood stick for the fretboard, polished wood for the guitar body, guitar pickups and so on. The luthiers have prioritized the location that contains body woods to be the topmost. They have provided the priorities for other locations as well which we will look in a moment. These locations within the factory warehouse look like -"

# ╔═╡ e33ecec5-5bde-475a-a94f-9db2f2c3fb9f
png_joinpathsplit__FILE__1assetsimagepng = let
    import PlutoUI
    PlutoUI.LocalResource(joinpath(split(@__FILE__, '#')[1] * ".assets", "image.png"))
end

# ╔═╡ 0e6f8ff0-2695-468a-a86b-50c82f803fef
md"As we can see there are little obstacles present (represented with smoothed lines) in between the locations. L6 is the top-priority location that contains the polished wood for preparing guitar bodies. Now, the task is to enable the robots so that they can find the shortest route from any given location to another location on their own.

The agents, in this case, are the robots. The environment is the guitar factory warehouse.

The states are the locations. The location in which a particular robot is present in the particular instance of time will denote its state. 

In our example, the actions will be the direct locations that a robot can go to from a particular location.

The rewards, now, will be given to a robot if a location (read it state) is directly reachable from a particular location.

L9 is directly reachable from L8. So, if a robot goes from L8 to L9 and vice-versa, it will be rewarded by 1. If a location is not directly reachable from a particular location, we do not give any reward (a reward of 0).
"

# ╔═╡ 21a93b71-abee-40d4-8233-e8f8627cc8b8
md"Let’s map each of the above locations in the warehouse to numbers (states). It will ease our calculations."

# ╔═╡ 1a290e0d-0da5-4640-a2ef-50134616e59a
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

# ╔═╡ ed51cb60-8527-4004-a924-4842a1ffe67a
md"The next step is to define the actions which as mentioned above represents the transition to the next state:"

# ╔═╡ 0cbfbb64-90e7-4115-82b5-e12152cc057e
actions = [1,2,3,4,5,6,7,8,9]

# ╔═╡ e75ae402-0e5a-4735-909a-49b5ea8be19a
md"Now the reward table:"

# ╔═╡ fb4c471e-24ea-4f69-af61-778e9f14ca9a
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

# ╔═╡ 54601339-33d8-4bd6-b7ca-9cdde30f39c6
md"If you understood it correctly, there isn't any real barrier limitation as depicted in the image. For example, the transition L4 to L1 is allowed but the reward will be zero to discourage that path."

# ╔═╡ b05c42c2-0a50-400f-889f-bff7ed177b5e
md"We would also need an inverse mapping from the states back to original location indicators."

# ╔═╡ 2d8d9f13-54e9-4c1f-b177-85a2541a14a1
state_to_location = Dict(value => key for (key, value) in location_to_state)

# ╔═╡ ce5ab309-b037-4fc3-82e4-56bab63e45bb
md"Before we write a helper function which will yield the optimal route for going from one location to another, let’s specify the two parameters of the Q-Learning algorithm - ɑ (learning rate) and 𝜸 (discount factor)."

# ╔═╡ 3ed32dd8-3128-4a44-922e-3968e00f3b75
alpha = 0.9 # Learning rate

# ╔═╡ ec63f28e-92a7-40c8-a12b-48a190f785ff
# Initialize parameters
gamma = 0.75 # Discount factor

# ╔═╡ 3a188403-3e05-4c1c-a8ca-acda6232a61b
md" The function will take a starting location and an ending location. So, we need to set the priority of the ending location to a larger integer like 999 and get the ending state from the location letter (such as L1, L2 and so on)."

# ╔═╡ 6ac6b281-fb77-49a7-951f-48d2f7b6b539
md"""
Learning is a continuous process, hence we will let the robot to explore the environment for a while and we will do it by simply looping it through 1000 times. We will then pick a state randomly from the set of states we defined above and we will call it current_state.

We then, being inside the loop, iterate through the rewards matrix to get the states that are directly reachable from the randomly chosen current state and we will assign those state in a list named playable_actions.

Note that so far we have not bothered about the starting location yet.

After that we can choose a state randomly from the playable_actions.

We can then update the Q-value using temporal difference and the Bellman equation.
"""

# ╔═╡ 50d29c4a-4d08-47d4-9f47-ca3285238dd6
md"To find the optimal route, we initialize the optimal route with the starting location"

# ╔═╡ 07cc6318-16f5-4955-9d64-c92541bddac8
md"We currently do not know about the next move of the robot. Thus we will set the next location to also be the starting location."

# ╔═╡ fe5ba573-416b-4ecd-8f75-e72705b9d564
md"Since we do not know the exact number of iterations the robot will take in order to find out the optimal route, we will simply loop the next set of processes until the next location is not equal to the ending location. This is where we will terminate the loop."

# ╔═╡ 0f4c419a-72fb-400d-b1d4-bcffc444f63b
md"here is the whole code:"

# ╔═╡ 9dddac9e-45b1-49e4-a431-fb6c5079a327
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

# ╔═╡ d1f82853-427e-4160-8b14-622d5f90d612
get_optimal_route("L9", "L1")

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
PlutoUI = "~0.7.27"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.7.1"
manifest_format = "2.0"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "8eaf9f1b4921132a4cff3f36a1d9ba923b14a481"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.4"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "024fe24d83e4a5bf5fc80501a314ce0d1aa35597"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.0"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

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

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "8076680b162ada2a031f707ac7b4953e30667a37"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.2"

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

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"

[[deps.Parsers]]
deps = ["Dates"]
git-tree-sha1 = "d7fa6237da8004be601e19bd6666083056649918"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.1.3"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "fed057115644d04fba7f4d768faeeeff6ad11a60"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.27"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
"""

# ╔═╡ Cell order:
# ╟─bbbb4e00-691f-11ec-36a7-117d098001a2
# ╟─ef140ba1-1ecf-4290-acf4-322d622ae260
# ╟─dae558db-a01b-4e60-a4ec-93d20556d56d
# ╟─f677c230-4816-4cf1-adb3-9603c8b3b8ed
# ╟─a297c034-edcb-4d0b-a57b-610268566e2c
# ╟─a119d090-9f01-4028-b93d-6cee215173e8
# ╟─9e3e3f5b-e92d-4fca-a741-8241c46bd4ec
# ╟─e33ecec5-5bde-475a-a94f-9db2f2c3fb9f
# ╟─0e6f8ff0-2695-468a-a86b-50c82f803fef
# ╟─21a93b71-abee-40d4-8233-e8f8627cc8b8
# ╟─1a290e0d-0da5-4640-a2ef-50134616e59a
# ╟─ed51cb60-8527-4004-a924-4842a1ffe67a
# ╟─0cbfbb64-90e7-4115-82b5-e12152cc057e
# ╟─e75ae402-0e5a-4735-909a-49b5ea8be19a
# ╟─fb4c471e-24ea-4f69-af61-778e9f14ca9a
# ╟─54601339-33d8-4bd6-b7ca-9cdde30f39c6
# ╟─b05c42c2-0a50-400f-889f-bff7ed177b5e
# ╟─2d8d9f13-54e9-4c1f-b177-85a2541a14a1
# ╟─ce5ab309-b037-4fc3-82e4-56bab63e45bb
# ╟─3ed32dd8-3128-4a44-922e-3968e00f3b75
# ╟─ec63f28e-92a7-40c8-a12b-48a190f785ff
# ╟─3a188403-3e05-4c1c-a8ca-acda6232a61b
# ╟─6ac6b281-fb77-49a7-951f-48d2f7b6b539
# ╟─50d29c4a-4d08-47d4-9f47-ca3285238dd6
# ╟─07cc6318-16f5-4955-9d64-c92541bddac8
# ╟─fe5ba573-416b-4ecd-8f75-e72705b9d564
# ╟─0f4c419a-72fb-400d-b1d4-bcffc444f63b
# ╠═9dddac9e-45b1-49e4-a431-fb6c5079a327
# ╠═d1f82853-427e-4160-8b14-622d5f90d612
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
