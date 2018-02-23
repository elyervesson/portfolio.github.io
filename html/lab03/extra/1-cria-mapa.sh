#!/bin/bash
export PATH=$PATH:./node_modules/.bin/

# d3.scaleThreshold().domain([-0.001, 0.001, 1]).range(d3.schemeRdBu[3])
# d3.scaleSequential(d3.interpolateViridis).domain([0, 100])
# d3.scaleThreshold().domain([-60.0, -30.0, -10.0, 0, 10.0, 30.0, 60.0]).range(d3.schemePRGn[7])

# a expressão js que decide os fills baseados em uma escala
EXP_ESCALA='z = d3.scaleSequential(d3.interpolateBrBG).domain([-60.0, 60.0, 0.0]),
        	d.features.forEach(f => f.properties.fill = z(f.properties["Crescimento entre 2011 e 2013 (pp*)"])),
        	d'
#EXP_ESCALA='z = d3.scaleThreshold().domain([-30, -10, 10, 30, 50, 70]).range(d3.schemeOrRd[]),
#        	d.features.forEach(f => f.properties.fill = z(f.properties["Crescimento entre 2011 e 2013 (pp*)"])),
#        	d'

ndjson-map -r d3 -r d3=d3-scale-chromatic \
  "$EXP_ESCALA" \
< geo4-municipios-e-aprendizado-simplificado.json \
| ndjson-split 'd.features' \
| geo2svg -n --stroke none -w 1000 -h 600 \
  > aprendizagem-na-pb-choropleth.svg

