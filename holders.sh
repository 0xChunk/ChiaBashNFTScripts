#!/bin/bash
####################################################################
#                                                                  #
#    ██████╗ ██╗  ██╗ ██████╗██╗  ██╗██╗   ██╗███╗   ██╗██╗  ██╗   #
#   ██╔═████╗╚██╗██╔╝██╔════╝██║  ██║██║   ██║████╗  ██║██║ ██╔╝   #
#   ██║██╔██║ ╚███╔╝ ██║     ███████║██║   ██║██╔██╗ ██║█████╔╝    #
#   ████╔╝██║ ██╔██╗ ██║     ██╔══██║██║   ██║██║╚██╗██║██╔═██╗    #
#   ╚██████╔╝██╔╝ ██╗╚██████╗██║  ██║╚██████╔╝██║ ╚████║██║  ██╗   #
#    ╚═════╝ ╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝  ╚═╝   #
#                                                                  #
#            Mintgarden.io NFTcollection owner list                #
#                         VERSION 0.1                              #
#                       Twitter:@0xChunk                           #
####################################################################

# Discard any diagnostic output, errors, and send it to stdout
exec 2>&1

# requirements:
#curl
#jq

####### CollectionID ###############
if [ "$*" == "" ]
   then
   COLLECTION_ID="col125jqur8a9t6gj2375dgz4wnvlsrufzl6wjh8wez52rzm24dt3yaqvhxfx4"
   else
   COLLECTION_ID=$1
fi

URL="https://api.mintgarden.io/collections/"
SIZE=100
NEXT=""
PAGE=" "
echo '####################################################################
#                                                                  #
#    ██████╗ ██╗  ██╗ ██████╗██╗  ██╗██╗   ██╗███╗   ██╗██╗  ██╗   #
#   ██╔═████╗╚██╗██╔╝██╔════╝██║  ██║██║   ██║████╗  ██║██║ ██╔╝   #
#   ██║██╔██║ ╚███╔╝ ██║     ███████║██║   ██║██╔██╗ ██║█████╔╝    #
#   ████╔╝██║ ██╔██╗ ██║     ██╔══██║██║   ██║██║╚██╗██║██╔═██╗    #
#   ╚██████╔╝██╔╝ ██╗╚██████╗██║  ██║╚██████╔╝██║ ╚████║██║  ██╗   #
#    ╚═════╝ ╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝  ╚═╝   #
#                                                                  #
#            Mintgarden.io NFTcollection owner list                #
#                         VERSION 0.1                              #
#                       Twitter:@0xChunk                           #
####################################################################'
echo "collection ID: 
$COLLECTION_ID
####################################################################"


while [[ $NEXT != $PAGE ]] 
do
   echo "
####################################################################
   fetching page: $NEXT"
   nft_list=$(curl "$URL$COLLECTION_ID/nfts?size=$SIZE&page=$NEXT")
   echo $nft_list | jq '.items[] |.name + "," +.owner_address_encoded_id' -r  >> holders.csv
   PAGE=$(echo $nft_list | jq .page -r)
   NEXT=$(echo $nft_list | jq .next -r)
   echo "
####################################################################
   found next page: $NEXT
   "
   ((PAGES=PAGES+1))
done

if [[ $PAGE == $NEXT ]]
then
   echo "completed $PAGES of $SIZE nfts per page"
   fi
