## Creating a Data Package for NES-LTER Chl Transect Cruise Data

This repository displays the workflow used to process the NES-LTER Transect cruise chlorophyll data from CTD rosette in preparation for publication to the Environmental Data Initiative repository.

This workflow includes the following:
1) compiles cruise data from the [REST API](https://github.com/WHOIGit/nes-lter-ims/wiki/Using-REST-API) and supplies useful fields for the end user
2) merges cruise data from additional sources
3) cleans the provided data
4) performs quality assurance on the data
5) assembles and outputs the final XML file for submission to EDI

**Base Requirements:**
- Microsoft Excel
- R and R studio (*packages:* tidyverse, readxl, lubridate, devtools, EMLassemblyline, EML, maps, xml2)

### Collaborators:
Heidi Sosik (creator), Taylor Crockford (technician), Susanne Menden-Deuer (creator), Pierre Marrec (creator), Stace Beaulieu (associate; co-PI for the NES-LTER project), Jaxine Wolfe (associate; metadata provider)

### Package Status:
Not published.