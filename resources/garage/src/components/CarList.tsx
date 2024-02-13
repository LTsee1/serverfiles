import React, { ReactNode } from 'react';

import { Typography, Box, useTheme,Stack,Accordion,AccordionSummary,AccordionDetails,List,Collapse,ListItem,ListSubheader } from '@mui/material';
import styled from '@emotion/styled';
import { green, grey, orange, red } from '@mui/material/colors';
import DirectionsCarIcon from '@mui/icons-material/DirectionsCar';
import { GarageItem } from '../types/garage';
import VehicleDetails from './VehicleDetails';
const Container = styled.div<{ backgroundColor: string }>`
  display: flex;
 border-radius: 10px;
  padding: 1.5rem;
  height: 8.5rem;
  margin-bottom: 1rem;
  
  background-color: ${({ backgroundColor }) => backgroundColor};
`;


interface CarProps {
    vehicles : any;
  }
  
  const CarList = ({ vehicles }: CarProps) => {
    const theme = useTheme();

    const typeIcon = {
        car: {
          icon: <DirectionsCarIcon sx={{ fontSize: 35 }} />,
          status: {
            out: orange[500],
            garaged: green[500],
            impounded: red[500],
            seized: red[500],
            unknown: grey[500],
          },
        },
      };

      return (
        <Container backgroundColor={theme.palette.primary.dark} >
        <Box>
          {Object.keys(vehicles).map((key) => (
    

               <div key={key}>
                {vehicles[key].map((veh: GarageItem) => {
                  return (
               
                <Box>
                
                    <Box
                     sx={{
                       display: 'flex',
                       justifyContent: 'space-between',
                       width: '100%',
                       alignItems: 'center',
                     }}
                    >
                     <Box sx={{ display: 'flex', gap: 3, alignItems: 'center' }}>
                       {typeIcon["car"].icon}
                       <Stack spacing={1}>
                         <Typography sx={{ fontSize: 15 }}>
                           {veh.brand + ' ' + veh.vehicle}
                         </Typography>
                         <Typography sx={{ fontSize: 15 }}>{veh.plate}</Typography>
                       </Stack>
                     </Box>
                     <Typography sx={{ fontSize: 14 }}>{veh.state.toUpperCase()}</Typography>
                    </Box>
                 
                    <VehicleDetails veh={veh} />
                    </Box>
                  
                  );
                })}
        
             </div>
          ))}
        </Box>
        </Container>
      );    
};
  
  export default CarList;