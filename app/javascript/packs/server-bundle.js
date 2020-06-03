import ReactOnRails from "react-on-rails";

import WatchersBlock from "../bundles/app/TicketShowPage/components/WatchersBlock";
import CompanyStatistics from "../bundles/app/CompanyOwnerDashboard/components/CompanyStatistics";
import Calendar from "../bundles/app/Units/components/Calendar";
import Units from "../bundles/app/shared/components/Units";
import QrCode from "qrcode.react";

ReactOnRails.register({
  WatchersBlock,
  CompanyStatistics,
  Calendar,
  QrCode,
  Units,
});
