echo "Building from src/"
nasm -f macho src/hello_world.asm
ld -e _start -o bin/hello_world src/hello_world.o -macosx_version_min 10.8  -lSystem
echo "Saved in bin/hello_world"
rm src/hello_world.o
