import App from './src/App';
import { AppIcon } from './icon';

interface Settings {
  language: 'en';
}

export const path = '/garage';
export default (settings: Settings) => ({
  id: 'GARAGE',
  path,
  nameLocale: "Garage", 
  color: '#fff',
  backgroundColor: '#333',
  icon: AppIcon,
  app: App,
});