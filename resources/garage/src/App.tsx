import React, { useEffect, useState } from 'react';

import { i18n } from 'i18next';
import {
  Theme,
  Paper,
  Typography,
  BottomNavigation,
  BottomNavigationAction,
  StyledEngineProvider,
} from '@mui/material';
import Header, { HEADER_HEIGHT } from './components/Header';
import CarList from './components/CarList';
import styled from '@emotion/styled';
import { Link, NavLink, useHistory, useLocation } from 'react-router-dom';
import { path } from '../npwd.config';
import { HomeRounded, InfoRounded } from '@mui/icons-material';
import ThemeSwitchProvider from './ThemeSwitchProvider';
import { RecoilRoot } from 'recoil';
import { useNuiEvent } from './hooks/useNuiEvent';
import { indigo, teal } from '@mui/material/colors';
import './index.css';
import fetchNui from './utils/fetchNui';
import {ServerPromiseResp} from './types/common';
import { GarageItem } from './types/garage';
const Container = styled(Paper)`
  flex: 1;
  display: flex;
  flex-direction: column;
  box-sizing: border-box;
  max-height: 100%;
`;

const LinkItem = styled(Link)`
  font-family: sans-serif;
  text-decoration: none;
`;

const Content = styled.div`
  flex: 1;
  display: flex;
  flex-direction: column;
  box-sizing: border-box;
  padding: 1.5rem;
  max-height: calc(100% - 3.5rem - ${HEADER_HEIGHT});
  overflow: auto;
  background: ${indigo[700]};
`;

const Footer = styled.footer`
  margin-top: auto;
`;

interface AppProps {
  theme: Theme;
  i18n: i18n;
  settings: any;
}

export function App(props: AppProps) {
  const history = useHistory();
  const { pathname } = useLocation();
  const [nuiData, setNuiData] = useState(null);

  const [page, setPage] = useState(pathname);

  const [vehicles, setVehicles] = useState<GarageItem[] | undefined>([]);
  const [mappedVeh, setMappedVeh] = useState<any>(null);

  const isDarkMode = 'dark'

  useEffect(() => {
      fetchNui<ServerPromiseResp<GarageItem[]>>(
          'npwd:esx-garage:getVehicles',
          null
      ).then((resp) => {
          setVehicles(resp.data);
      });
  }, []);

  useEffect(() => {
    if (vehicles) {
        const mappedVehicles = vehicles?.reduce((vehs: any, vehicle: any) => {
            if (!vehs[vehicle.type]) vehs[vehicle.type] = [];
            vehs[vehicle.type].push(vehicle);
            return vehs;
        }, {});

        setMappedVeh(mappedVehicles);
    }
}, [vehicles]);

  //setPage(newPage);
  const handleChange = (_e: any, newPage: any) => {};

  return (
    <StyledEngineProvider injectFirst>
      <ThemeSwitchProvider mode={props.theme.palette.mode}>
        <Container square elevation={0}>
          <Header>Twoje Pojazdy</Header>
          <Content>
        
              
              <CarList vehicles={[{}]} />



    

          
          </Content>

      
        </Container>
      </ThemeSwitchProvider>
    </StyledEngineProvider>
  );
}

export default function WithProviders(props: AppProps) {
  return (
    <RecoilRoot override key="garage">
      <App {...props} />
    </RecoilRoot>
  );
}
