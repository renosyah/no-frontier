extends Node
class_name RadioChatters

const COMMAND_ACKNOWLEDGEMENT = 1
const AMBUSH_INITIATED = 2
const LOW_AMMO = 3
const AREA_CLEAR = 4
const CASUALTY = 5
const COMBAT_STATUS = 6
const ENEMY_SPOTTED = 7
const MOVEMENT = 8
const RETREAT = 9

onready var US_RADIO = {
	COMMAND_ACKNOWLEDGEMENT:{
		"Roger.":"path/to/audio.ogg",
		"Copy that.":"path/to/audio.ogg",
		"Wilco.":"path/to/audio.ogg",
		"Moving now.":"path/to/audio.ogg",
		"On the way.":"path/to/audio.ogg",
		"Orders received.":"path/to/audio.ogg",
	},
	AMBUSH_INITIATED:{
		"Targets in sight.":"path/to/audio.ogg",
		"Hold… hold…":"path/to/audio.ogg",
		"Spring the ambush!":"path/to/audio.ogg",
		"Engaging now!":"path/to/audio.ogg",
	},
	LOW_AMMO:{
		"Low on ammo!":"path/to/audio.ogg",
		"Running dry!":"path/to/audio.ogg",
		"We’re out!":"path/to/audio.ogg",
		"Need resupply!":"path/to/audio.ogg",
	},
	AREA_CLEAR:{
		"Area secure.":"path/to/audio.ogg",
		"Targets down.":"path/to/audio.ogg",
		"Clear.":"path/to/audio.ogg",
		"We’re good here.":"path/to/audio.ogg",
	},
	CASUALTY:{
		"Man down!":"path/to/audio.ogg",
		"We’ve got wounded!":"path/to/audio.ogg",
		"Need a medic!":"path/to/audio.ogg",
		"Taking losses!":"path/to/audio.ogg",
	},
	COMBAT_STATUS:{
		"Engaging.":"path/to/audio.ogg",
		"Suppressing!":"path/to/audio.ogg",
		"Reloading!":"path/to/audio.ogg",
		"We’re pinned!":"path/to/audio.ogg",
		"Pushing forward!":"path/to/audio.ogg",
	},
	ENEMY_SPOTTED:{
		"Contact!":"path/to/audio.ogg",
		"Enemy spotted.":"path/to/audio.ogg",
		"Eyes on target.":"path/to/audio.ogg",
		"Taking fire!":"path/to/audio.ogg",
		"Heavy contact!":"path/to/audio.ogg",
	},
	MOVEMENT:{
		"We’re moving.":"path/to/audio.ogg",
		"Crossing now.":"path/to/audio.ogg",
		"Entering the area.":"path/to/audio.ogg",
		"Reached position.":"path/to/audio.ogg",
		"Holding here.":"path/to/audio.ogg",
	},
	RETREAT:{
		"Pull back!":"path/to/audio.ogg",
		"Break contact!":"path/to/audio.ogg",
		"Fall back!":"path/to/audio.ogg",
		"Disengaging!":"path/to/audio.ogg",
	},
}

onready var VIET_RADIO = {
	COMMAND_ACKNOWLEDGEMENT:{
		"Rõ.":"path/to/audio.ogg",
		"Đã rõ.":"path/to/audio.ogg",
		"Nhận lệnh.":"path/to/audio.ogg",
		"Đang di chuyển.":"path/to/audio.ogg",
		"Thi hành.":"path/to/audio.ogg",
	},
	AMBUSH_INITIATED:{
		"Địch đã vào.":"path/to/audio.ogg",
		"Chờ lệnh.":"path/to/audio.ogg",
		"Nổ súng!":"path/to/audio.ogg",
		"Tiêu diệt!":"path/to/audio.ogg",
	},
	LOW_AMMO:{
		"Sắp hết đạn!":"path/to/audio.ogg",
		"Thiếu đạn!":"path/to/audio.ogg",
		"Hết đạn!":"path/to/audio.ogg",
		"Cần tiếp tế!":"path/to/audio.ogg",
	},
	AREA_CLEAR:{
		"Khu vực an toàn.":"path/to/audio.ogg",
		"Đã tiêu diệt.":"path/to/audio.ogg",
		"Sạch địch.":"path/to/audio.ogg",
		"Hoàn tất.":"path/to/audio.ogg",
	},
	CASUALTY:{
		"Có thương binh!":"path/to/audio.ogg",
		"Có người bị thương!":"path/to/audio.ogg",
		"Tổn thất!":"path/to/audio.ogg",
		"Cần cứu thương!":"path/to/audio.ogg",
	},
	COMBAT_STATUS:{
		"Đang giao chiến.":"path/to/audio.ogg",
		"Bắn áp chế!":"path/to/audio.ogg",
		"Nạp đạn!":"path/to/audio.ogg",
		"Bị ghìm chặt!":"path/to/audio.ogg",
		"Xung phong!":"path/to/audio.ogg",
	},
	ENEMY_SPOTTED:{
		"Phát hiện địch!":"path/to/audio.ogg",
		"Có địch!":"path/to/audio.ogg",
		"Bị bắn!":"path/to/audio.ogg",
		"Địch phía trước!":"path/to/audio.ogg",
		"Giao tranh!":"path/to/audio.ogg",
	},
	MOVEMENT:{
		"Đang tiến quân.":"path/to/audio.ogg",
		"Đã vào khu vực.":"path/to/audio.ogg",
		"Đến vị trí.":"path/to/audio.ogg",
		"Giữ vị trí.":"path/to/audio.ogg",
		"Dừng lại.":"path/to/audio.ogg",
	},
	RETREAT:{
		"Rút lui!":"path/to/audio.ogg",
		"Thoát ly!":"path/to/audio.ogg",
		"Rời khỏi giao tranh!":"path/to/audio.ogg",
		"Rút quân!":"path/to/audio.ogg",
	},
}
