#!/bin/sh

sed -i s/ref/Reference/ $1
sed -i s/value/Value/ $1
sed -i s/footprint/Footprint/ $1
sed -i s/Field1/Part/ $1
sed -i s/Field2/DigikeyPart/ $1
