#!/usr/bin/env bash

tmpdir="$TMPDIR/spt_status"
data_file="$tmpdir/current.txt"

if [ ! -d "$tmpdir" ]; then
    printf "\rInitializing..."

    # create the directory
    mkdir "$tmpdir"

    # initialize the data file
    echo "null" >"$data_file"
    echo "false" >>"$data_file"

    printf "\rInitialized successfully!"

    exit 0
fi

# the first line of the data file is the output of the last run
output=$(head -n 1 "$data_file" 2>/dev/null)

# the second line is whether or not we've already updated
updated=$(tail -n 1 "$data_file" 2>/dev/null)

if [ "$1" = "--update" ]; then
    printf "\rUpdating..."

    # only get the playback information if we haven't already updated
    if [ "$updated" != "true" ]; then
        # write the playback information to the data file
        echo "null" >"$data_file"

        # write that we've updated to the data file
        echo "true" >>"$data_file"
    fi

    exit 0
fi

# get the output from the data file
output=$(head -n 1 "$data_file" 2>/dev/null)

# if the output is null, get the playback information
if [ "$output" = "null" ]; then
    # format options:
    # %a: artist, %b: album, %p: playlist, %t: track, %h: show,
    # %f: flags (shuffle, repeat, like), %s: playback status, %v: volume, %d: current device

    # get the playback information
    pb=$(/usr/local/bin/spt playback --format "%s %a: %t" 2>/dev/null || echo "null")

    # write the playback information to the data file
    echo "$pb" >"$data_file"

    # write that we haven't updated to the data file
    echo "false" >>"$data_file"

    # get the output from the data file
    output=$(head -n 1 "$data_file" 2>/dev/null)
fi

# remove all newlines from the output
output=$(echo "$output" | tr -d '\n')

# max length of the output
max_length=35

# the speed at which the text should scroll (characters per second)
scroll_speed=10

if [ "$output" = "null" ]; then
    # if the output is null, print an error message and exit
    printf "\rSomething went wrong..."

    exit 1
fi

if [ ${#output} -gt $max_length ]; then
    # get the current time in seconds
    current_time=$(date +%s)

    # first character is the play/pause symbol
    play_pause_symbol="${output:0:2}"

    # the rest of the output is the track information
    output=${output:2}

    # calculate the scroll position based on the current time and scroll speed
    scroll_position=$((current_time * scroll_speed % (${#output} + max_length)))

    # create a padded version of the output with spaces
    padded_output="${output}$(printf '%*s' $((max_length)) '')${output}"

    # extract the substring to display based on the scroll position
    displayed_output="${padded_output:$scroll_position:(($max_length - 2))}"

    printf "\r%s%s " "$play_pause_symbol" "$displayed_output"

    exit 0
fi

padded_output="${output}$(printf '%*s' $((max_length + 1 - ${#output})) '')"
printf "\r%s" "$padded_output"

