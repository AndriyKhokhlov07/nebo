<?php 
ini_set('error_reporting', E_ALL);


session_start();

require_once('../api/Backend.php');


class Init extends Backend
{
	function fetch()
	{

$first_word = [
	'Stunning', 
	'Absolutely', 
	'Stylish', 
	'Modern',
	'Great',
	'Lovely', 
	'Amazing', 
	'Charming',
	'Cozy',
	'Trendy',
	'Cute',
	'Brand',
	'Prime',
	'Nice',
	'Beautiful'
];

$house_descriptions = [
	'The Crown Heights House' => [
		'private' => 'Explore New York City from this spacious, renovated apartment in historical Crown Heights , Brooklyn. This fully furnished apartment is the perfect home base whether you want to have a dinner party in its large, fully equipped kitchen, or experience the neighborhood’s renowned arts and entertainment scene. This apartment even has in-unit laundry — a luxury in New York',
		'2 ppl' => ''
	],
	'The Knickerbocker House' => [
		'private' => 'Experience the best of Brooklyn’s creative scene just steps from this renovated, furnished apartment, fully equipped with everything you need to get settled in — all you have to bring is your suitcase! Walk outside and find yourself in the heart of Bushwick, renowned for its street art and bustling community. This apartment includes access to the backyard, perfect for getting time outdoors, and is just a short walk from the neighborhood’s largest park.',
		'2 ppl' => 'Experience the best of Brooklyn’s creative scene just steps from this renovated, furnished apartment, fully equipped with everything you need to get settled in — all you have to bring is your suitcase! Walk outside and find yourself in the heart of Bushwick, renowned for its street art and bustling community. This apartment includes access to the backyard, perfect for getting time outdoors, and is just a short walk from the neighborhood’s largest park.'
	],
	'The Stuyvesant Heights House' => [
		'private' => 'Get a true New York experience in the kind of gorgeous pre-war brownstone Brooklyn is famous for, with exposed brick and beams melding with updated furniture and appliances. This apartment is located in the historic Stuyvesant Heights neighborhood, and is fully equipped with everything you’ll need to make it home — all you need is your suitcase!',
		'2 ppl' => ''
	],
	'The Lafayette House' => [
		'private' => 'This house is located in Bed-Stuy, a charming and central Brooklyn neighborhood with plenty of restaurants, cozy bars and hip boutiques. You can explore surrounding neighborhoods like Clinton Hill, Williamsburg, and Bushwick, or hop on the subway and be in Manhattan in 30 minutes. This brand new building is home to spacious apartments with modern amenities — including a fitness center!',
		'2 ppl' => ''
	],
	'The Williamsburg House' => [
		'private' => 'Enjoy all that Williamsburg has to offer from this spacious, open-plan apartment, complete with a stylish kitchen and plenty of room to live and work. This apartment is in a Prime Williamsburg area with plenty of coffee shops, restaurants and shopping, walking distance from multiple parks, and near some of Williamsburg’s most popular offerings. To top it all off, this building even has a Media Room, Resident Lounge, Bike Storage, Roof deck – with shower, grills, seating, & lounge area.',
		'2 ppl' => ''
	],
	'The Lexington House' => [
		'private' => '',
		'2 ppl' => ''
	],
	'The Montrose Williamsburg House' => [
		'private' => 'Enjoy all that Williamsburg has to offer from this spacious, open-plan apartment, complete with a massive kitchen, a flat-screen TV and plenty of room to live and work. This apartment is walking distance from multiple parks and near some of Williamsburg’s most popular offerings. To top it all off, this apartment even has free laundry — a luxury in New York!',
		'2 ppl' => ''
	],
	'The Irving House' => [
		'private' => 'Discover the best New York has to offer in this spacious, renovated apartment in the heart of the Bushwick creative scene. Enjoy access to two full kitchens, a large, fully furnished living room and even a dry bar for your entertainment, and explore the neighborhood’s famous murals and vibrant restaurant scene while you’re out and about.',
		'2 ppl' => ''
	],
	'The Central Park Manhattan House ' => [
		'private' => 'Experience the best of New York City from this renovated apartment just a few minutes’ walk from the renowned Central Park in Manhattan! With a fully equipped kitchen, large flat-screen TV and thoughtfully furnished living rooms and bedrooms, you’ll be able to make the most of your time in the city whether you’re hanging out at home or out exploring Manhattan. This apartment even has in-unit laundry — a luxury in New York!',
		'2 ppl' => 'Experience the best of New York City from this renovated apartment just a few minutes’ walk from the renowned Central Park in Manhattan! With a fully equipped kitchen, large flat-screen TV and thoughtfully furnished living rooms and bedrooms, you’ll be able to make the most of your time in the city whether you’re hanging out at home or out exploring Manhattan. This apartment even has in-unit laundry — a luxury in New York!'
	],
	'The Newkirk House' => [
		'private' => 'Get to know one of the historic cultural centers of Brooklyn from this fully furnished Flatbush apartment! This home is newly renovated, with stainless steel appliances in a fully equipped kitchen, and plenty of room to work from home or just relax. Central Brooklyn’s array of dining and shopping will give you endless opportunities for entertainment, or you can hop on the subway and head to Manhattan to explore even more.',
		'2 ppl' => ''
	],
	'The United Nations House (1278 / apt 13)' => [
		'private' => 'The apartment features a large eat-in kitchen with a dining table set and a living area with a sofa. The room is fully furnished with a full-size bed, chair, and side table.',
		'2 ppl' => ''
	],
	'The United Nations House (402 / apt 3)' => [
		'private' => 'This is a single room in a three-bedroom, two-bathroom apartment. The unit is located on the 2nd floor of a walk-up building and is recently remodeled with a finished wood floor throughout. The apartment features a large eat-in kitchen with a dining table set and a living area with a sofa. The room is fully furnished with a full-size bed, chair, and side table. There is one large window for great natural lighting and wood flooring. The room also includes a standard size closet for extra storage.',
		'2 ppl' => ''
	],
	'The Ridgewood House' => [
		'private' => 'This private bedroom in our 4 bedroom apartment, is an epitome of a co-living space! Equip with hi-speed WiFi and TV. High ceilings and a gorgeous lighting drench this duplex in absolute luxury. Common space including dining area and kitchen',
		'with bath' => 'This private bedroom with en-suite bath in our 4 bedroom apartment, is an epitome of a co-living space! Equip with hi-speed WiFi and TV. High ceilings and gorgeous lighting drench this duplex in absolute luxury. Common space including dining area and kitchen',
		'2 ppl' => 'This shared 2-people bedroom in our 4 bedroom apartment, is an epitome of a co-living space! Equip with hi-speed WiFi and TV. High ceilings and gorgeous lighting drench this duplex in absolute luxury. Common space including dining area and kitchen'
	],
	'The Bedford House' => [
		'private' => 'The Bedford House is located in Bed-Stuy, a historic Brooklyn neighborhood that feels like home with its quaint streets and vibrant culture. This home offers spacious apartments with a serene outdoor area, spacious common areas and modern amenities — all tied together by our coliving community. As you enjoy all the Bedford House has to offer, you’ll meet people from every corner of the world, building a community from the comfort of your home.',
		'2 ppl' => ''
	],
	'The Greenpoint House' => [
		'private' => "The Greenpoint House is in a charming and lively Brooklyn neighborhood, with plenty of coffee shops, restaurants and shopping in the area. If you're ready to explore more of Brooklyn or jet into Manhattan the subway is just around the corner, so commuting is even more convenient. These recently renovated units are beautifully furnished and there's even rooftop access so you can sip some wine while enjoying the view!",
		'2 ppl' => ''
	],
	'The Greenpoint House (115)' => [
		'private' => "The Greenpoint House is in a charming and lively Brooklyn neighborhood, with plenty of coffee shops, restaurants and shopping in the area. If you're ready to explore more of Brooklyn or jet into Manhattan the subway is just around the corner, so commuting is even more convenient. These recently renovated units are beautifully furnished and there's even rooftop access so you can sip some wine while enjoying the view!",
		'2 ppl' => ''
	],
	'The Greenpoint House (111)' => [
		'private' => "The Greenpoint House is in a charming and lively Brooklyn neighborhood, with plenty of coffee shops, restaurants and shopping in the area. If you're ready to explore more of Brooklyn or jet into Manhattan the subway is just around the corner, so commuting is even more convenient. These recently renovated units are beautifully furnished and there's even rooftop access so you can sip some wine while enjoying the view!",
		'2 ppl' => ''
	],
	'The Bed-Stuy House' => [
		'private' => 'This house is located in Bed-Stuy, a charming and central Brooklyn neighborhood with plenty of restaurants, cozy bars and hip boutiques. You can explore surrounding neighborhoods like Clinton Hill, Williamsburg, and Bushwick, or hop on the subway and be in Manhattan in 30 minutes. This brand new building is home to spacious apartments with modern amenities.',
		'2 ppl' => ''
	],
	'The Cypress House' => [
		'private' => 'This private bedroom with private bathroom in our 3 bedroom apartment/3 bathrooms , is an epitome of a co-living space! Equip with hi-speed WiFi and TV. Common space including dining area and kitchen',
		'2 ppl' => ''
	],
	'The Lewis House' => [
		'private' => 'Experience New York City from this spacious, renovated apartment in historic Bedford-Stuyvesant, Brooklyn. You’ll find plenty of space to rest and relax.  Bed-Stuy is a vibrant, exciting neighborhood, with tons of dining options within walking distance. Or you can hop on the subway and head to Manhattan to explore even more.',
		'2 ppl' => ''
	],
	'The Harlem House' => [
		'private' => 'Explore New York City from this home base located in an exciting part of Manhattan filled with plenty to see and do!  Guests enjoy spacious common areas within their apartment, including a living room and kitchen.',
		'2 ppl' => ''
	],
	'The Fort Greene House' => [
		'private' => "Modern digs meet vintage aesthetic in this spacious roommate-friendly apartment, located in prime Brooklyn. The full sized bed is fitted with brand new linens, plus towels for your use, a smart TV in your bedroom and the living area -- you'll have plenty of ways to rest and relax. Plus, enjoy a fitness center in the building accessible to you at all times!",
		'2 ppl' => ''
	],
	'The East Bushwick House' => [
		'private' => 'Explore New York City from this spacious, renovated apartment in Bushwick, Brooklyn. This fully furnished apartment is the perfect home base whether you want to have a dinner party in its large, fully equipped kitchen, or experience the neighborhood’s renowned arts and entertainment scene. This apartment even has in-unit laundry — a luxury in New York!',
		'2 ppl' => 'Explore New York City from this spacious, renovated apartment in Bushwick, Brooklyn. This fully furnished apartment is the perfect home base whether you want to have a dinner party in its large, fully equipped kitchen, or experience the neighborhood’s renowned arts and entertainment scene. This apartment even has in-unit laundry — a luxury in New York!'
	],
	'The Bushwick House' => [
		'private' => "Hello classic brooklyn style and goodbye tiny spaces! This spacious private bedroom is located in prime Bushwick. It's neutral colors and eye-catching art will make you feel at home in no time.  The in-unit washer/dryer and backyard cannot be more convienient! With elegant touches of exposed brick walls and marbled walls, how can you resist?",
		'2 ppl' => ''
	],
	'The Fresh Pond House' => [
		'private' => 'The Apartment is a perfect place to enjoy the relaxed atmosphere of Queens while being a short commute from Downtown Brooklyn or Manhattan. These apartments are the perfect space to call your home base, the neighborhood has a relaxed pace and historic streets so you can take a break from the bustle of big city life.',
		'2 ppl' => ''
	],
	'The Gates House' => [
		'private' => 'The Gates House is located in Bed-Stuy, a historic Brooklyn neighborhood that feels like home with its quaint streets and vibrant culture. This home offers spacious apartments with a serene outdoor area, spacious common areas and modern amenities — all tied together by our coliving community. As you enjoy all the Gates House has to offer, you’ll meet people from every corner of the world, building a community from the comfort of your home',
		'2 ppl' => ''
	],
	'The Downtown Brooklyn House' => [
		'private' => 'Discover the best of Brooklyn from this renovated, fully furnished apartment with beautiful views of the Manhattan skyline from the rooftop deck! This lovely apartment is fully furnished with everything you’ll need to get life started in NewYork City. Boerum Hill is a beautiful neighborhood with classic brownstones along tree-lined streets, with plenty of shopping and dining within walking distance, and it’s just a short subway ride from Manhattan.',
		'2 ppl' => ''
	],
	'The Upper Manhattan House' => [
		'private' => 'Explore New York City from this home base located in an exciting part of Manhattan filled with plenty to see and do! The Upper Manhattan House is spread over two adjoining apartment buildings, with two floors of individual apartments in each building. Members enjoy spacious common areas within their apartment, including a living room and kitchen, and one room includes access to a large balcony.',
		'2 ppl' => ''
	],
	'The Kensington House' => [
		'private' => 'Get to know one of the historic cultural centers of Brooklyn from this fully furnished Flatbush apartment! This home is newly renovated, with stainless steel appliances in a fully equipped kitchen, and plenty of room to work from home or just relax. Central Brooklyn’s array of dining and shopping will give you endless opportunities for entertainment, or you can hop on the subway and head to Manhattan to explore even more',
		'2 ppl' => ''
	],
	"The Hell's Kitchen House" => [
		'private' => 'Apartment in the Heart of Manhattan. 10 Minutes Away Walking to Times Square and Central Park, With Many Opportunities in a Wonderful Place to Live Having Access to the Best Restaurants, and the best of everything in New York.',
		'2 ppl' => ''
	]
];

$houses = $this->pages->get_pages([
	'menu_id'=>5,
	'parent_id'=>253, 
	'not_tree'=>1
]);
$houses = $this->request->array_to_key($houses, 'id');

foreach ($houses as $h) 
{
	if(!empty($h->blocks2))
	{
		$h->blocks2 = unserialize($h->blocks2);
	}
}
$rooms = $this->beds->get_rooms(['house_id' => array_keys($houses)]);
$rooms = $this->request->array_to_key($rooms, 'id');

$rooms_labels = $this->beds->get_room_labels(array_keys($rooms));

foreach($rooms_labels as $rl)
{
	$rooms[$rl->room_id]->labels[$rl->id] = $rl;
}

foreach($rooms as $room) 
{ 
if(empty($room->title))
{
	if($room->type_id == 2)
	{
		$room_type = '2-people shared ROOM';
	}	
	else
	{
		$room_type = 'Private ROOM';
	}

	if(!empty($houses[$room->house_id]->blocks2['district']))
	{
		$district = $houses[$room->house_id]->blocks2['district'];
	}
	else
	{
		$district = "Brooklyn";
	}

	$private_bath = '';

	if(!empty($room->labels))
	{
		// Private bath
		if(!empty($room->labels[4]))
		{
			$private_bath = ' with Bathroom';
		}
	}

	$title = $first_word[array_rand($first_word)] . ' ' . $room_type . $private_bath . ' in ' . $district;

	$room->title = $title;

	if($room->type_id == 2 && !empty($house_descriptions[$houses[$room->house_id]->name]['2 ppl']))
	{
		$room->description = $house_descriptions[$houses[$room->house_id]->name]['2 ppl'];
	}
	elseif(!empty($private_bath) && !empty($house_descriptions[$houses[$room->house_id]->name]['with bath']))
	{
		$room->description = $house_descriptions[$houses[$room->house_id]->name]['with bath'];
	}
	else
	{
		$room->description = $house_descriptions[$houses[$room->house_id]->name]['private'];
	}

	if(!empty($room->description))
	{
		$this->beds->update_room($room->id, [
			'title' => $room->title,
			'description' => $room->description,
		]);
	}

	print_r($houses[$room->house_id]->name);
	echo '<br>';
	print_r($room->title);
	echo '<br>';
	print_r($room->description);
	echo '<br>';
}
}


	}
}


$init = new Init();
$init->fetch();

