echo "Building from src/"
nasm -f macho src/calc.asm
ld -e _start -o bin/calc src/calc.o -macosx_version_min 10.8  -lSystem
echo "Saved in bin/hello_world"
rm src/*.o
