# Piet

Piet programs are images: execution is driven by the size and hue
differences between adjacent blocks of colour, and the instruction pointer
wanders the image guided by a direction pointer and a codel chooser.

Writing one means laying out colour blocks whose *area* encodes each pushed
integer and whose hue transitions encode the operations — normally done with
a dedicated editor, and verified by stepping an interpreter over the image.

Rather than commit a PNG that looks like a Piet program but does not
execute, this directory records the gap.

Status: not implemented.
