(* Selected text is imported ASAP *)
set textToBeTranslated to "{popclip text}"

(* Application is launced*)
tell application "Tureng"
	launch
	activate
end tell

delay 0.3

try
	(* System utilities are called to point to search bar and paste the text *)
	tell application "System Events" to tell process "Tureng"
		activate -- Required when switched from a full screen app
		set frontmost to true
		set searchBar to text field 1 of group 4 of toolbar 1 of window 1
		set value of searchBar to textToBeTranslated
		set focused of searchBar to true
		keystroke return
	end tell
on error -- Error may be caused due to app delays (mostly switch between full screen apps)
	(* Second trial*)
	delay 0.7
	try
		(* This 'tell block' is the same as the one above *)
		tell application "System Events" to tell process "Tureng"
			activate
			set frontmost to true
			set searchBar to text field 1 of group 4 of toolbar 1 of window 1
			set value of searchBar to textToBeTranslated
			set focused of searchBar to true
			keystroke return
		end tell
	on error -- Second error.
		beep
	end try
end try
