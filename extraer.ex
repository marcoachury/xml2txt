#!/usr/bin/eui
-- Extract plain text from document.xlm (from MS Word unzipped file)
-- Este programa extrae texto plano de un archivo document.xml.
-- El objetivo es rescatar texto de un archivo docx dañado.
-- Requires Euphoria 3.1 Interpreter

-- Init variables
sequence buffer
sequence output
object line
integer fn
integer intag
integer caracter

intag=0   -- Not inside a <>
output="" 

-- read a text file into a sequence
fn = open("./document.xml", "r")
if fn = -1 then
    puts(1, "Couldn't open document.xml\n")
    abort(1)
end if

buffer = {}
while 1 do
    line = gets(fn)
    if atom(line) then
        exit   -- -1 is returned at end of file
    end if
    buffer = buffer & line
end while
close(fn)


? length(buffer)

for i = 1 to length(buffer) do
	caracter=buffer[i]
	if not intag then
		if caracter = '<' then
			intag=1
		else
			output = output & buffer[i]
		end if
	else
		if caracter='>' then
			intag=0
		end if
	end if
end for

puts(1, output)

fn = open("salida.txt", "w")
	puts(fn, output)
close(fn)

? "\nSuccess.  Text file output: salida.txt\n"

