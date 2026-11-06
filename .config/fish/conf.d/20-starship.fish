if status is-interactive
    # Avoid duplicate empty lines with Starship & Astronaut
    functions --erase __astronaut_prompt_spacing

    if command -q starship
        starship init fish | source
    else
	# fallback to native Astronaut prompt
        fish_config prompt choose astronaut

        function __astronaut_prompt_spacing --on-event fish_prompt
            printf '\n'
        end
    end
end
